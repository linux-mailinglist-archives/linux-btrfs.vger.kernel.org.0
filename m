Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E48A52CA07
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 May 2022 05:08:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233040AbiESDIi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 18 May 2022 23:08:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbiESDIg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 18 May 2022 23:08:36 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63E97D9E83
        for <linux-btrfs@vger.kernel.org>; Wed, 18 May 2022 20:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1652929715; x=1684465715;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=iKzAFiDLKJhL5lFQX7s/O0b9OAzuVRAgCLJSBsvKlJE=;
  b=KDMoZ/A68nH4jFn77KQ3MmQalFFHw6HscNC+yRJ3O2eutCK3/8w3Cpl7
   kKiFJXIyEcZoP5GN9HPgW8UFwQejNWzdG9h9G3vbryyG9I6qIwtfG10xj
   JbJMu/xNLTpUtXvlOkGxaJbsUdDIaubBmJtwaotZl2p/JKGDOtjr8ggpV
   e+lRxeP+Ux9nG62TG7Ibbhd7HfLaky9GrK4ftFCQCF88OQxcB0gQDchTZ
   b5spLPEFDAqD12Ltx/tL3G4P/JcFqej+HnrqJP3m0RGS78/oQ3VhlluS2
   sLEhey+BbugkLAsSvgPZc/2wKod0hXbxochKFp0/fVuID0FE8E3eDsNe1
   g==;
X-IronPort-AV: E=Sophos;i="5.91,236,1647273600"; 
   d="scan'208";a="199556799"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 19 May 2022 11:08:32 +0800
IronPort-SDR: s1hyYMGW8SLSvYX63ElvTI6or9Wx5VPsTyJZc4lIiuDlKMZ95Q4fX1SO+pbXg0F4f86mFFPAOH
 L3B4pWOcVsE0AQfL6POomDSEbXq7Sm8eXV0Ce48tzNQFh2tJRypKijCeak9DuNsAStaBXDUDSu
 yPmfAmg89vZmfbhJjXIg5S4nFIoSFnM9oMCxCvKrmkhojs5rEIhdTjM4gdJ4EgYCQFCv+3G65m
 vSriT0BOJIqMFQEJQYL8TE17xhvY9SQvxEixI3hsgbuGbSqh3PhBn1JuE5JEaZgtYJm4hfJt85
 jNm1i7ghev+RxIHgN9nr2H50
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 May 2022 19:31:35 -0700
IronPort-SDR: vtkahV5yUZK7/3Fe2qBDX2kqBamPeHQal9hJwBdQ7ZwJo/MjEfPJeDE+TCXSinQ3SI1zPo1GRB
 8iM03uffU1gNOeEny1uNbo4vDz4OVkr9stm9lZTtE3KIaHsnkL0EQK4OdwsNfpUOJiYDgkkBkk
 bhsiTvqZhgmQ1Rcd48dBUpY+S55zLJLHdnLul61lg59qWgmX60N0BQbv+sOes18HFdDU09OqMT
 q/e2r0QgEXuwXF8/1iH/l6NI+ntdIab/+A6kFTylAwL5lStz81EwWoHhTX80rEv4kS5Y19NzsR
 MgI=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 May 2022 20:08:33 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4L3ZYq6Pfzz1SVp5
        for <linux-btrfs@vger.kernel.org>; Wed, 18 May 2022 20:08:31 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1652929710; x=1655521711; bh=iKzAFiDLKJhL5lFQX7s/O0b9OAzuVRAgCLJ
        SBsvKlJE=; b=Wz9R8/72j7o0/HjkO54/uNZ7vziwLqXBQOx2WZe1qEsSDBmqYAY
        oMOjpxPnGBnz+q+koTOKO3drn7FOj/jhxR0PTW1FJ7YLYdFtlYLeLGGN3yqvtwdr
        uts4LUP4ysOxN9iynlkWmhdkEs1tc1G3KNFA528x+jtAzYhfzX3F8jTjGnXp//sA
        rsE8C3oCVAzXP+CvDtHdo8BS4Oa1/JBePKnEcjfmBeFehBxoE9CWKq1Q/U6ExkMw
        hH5S6Kmi+EQY3sVzRRp11jv54IT+de7lJq7eYYN/WT35dSgh82O8SztxjP5NqAI5
        lf5E1L/acuF281Lj4heVeUrWlZG2K+SHppA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Imt44YV4RxKK for <linux-btrfs@vger.kernel.org>;
        Wed, 18 May 2022 20:08:30 -0700 (PDT)
Received: from [10.225.163.43] (unknown [10.225.163.43])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4L3ZYm2BJDz1Rvlc;
        Wed, 18 May 2022 20:08:28 -0700 (PDT)
Message-ID: <7f9cb19b-621b-75ea-7273-2d2769237851@opensource.wdc.com>
Date:   Thu, 19 May 2022 12:08:26 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [dm-devel] [PATCH v4 00/13] support non power of 2 zoned devices
Content-Language: en-US
To:     Theodore Ts'o <tytso@mit.edu>, Christoph Hellwig <hch@lst.de>
Cc:     Pankaj Raghav <p.raghav@samsung.com>, axboe@kernel.dk,
        pankydev8@gmail.com, gost.dev@samsung.com,
        jiangbo.365@bytedance.com, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, dm-devel@redhat.com,
        dsterba@suse.com, linux-btrfs@vger.kernel.org
References: <CGME20220516165418eucas1p2be592d9cd4b35f6b71d39ccbe87f3fef@eucas1p2.samsung.com>
 <20220516165416.171196-1-p.raghav@samsung.com>
 <20220517081048.GA13947@lst.de> <YoPAnj9ufkt5nh1G@mit.edu>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <YoPAnj9ufkt5nh1G@mit.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 5/18/22 00:34, Theodore Ts'o wrote:
> On Tue, May 17, 2022 at 10:10:48AM +0200, Christoph Hellwig wrote:
>> I'm a little surprised about all this activity.
>>
>> I though the conclusion at LSF/MM was that for Linux itself there
>> is very little benefit in supporting this scheme.  It will massively
>> fragment the supported based of devices and applications, while only
>> having the benefit of supporting some Samsung legacy devices.
> 
> FWIW,
> 
> That wasn't my impression from that LSF/MM session, but once the
> videos become available, folks can decide for themselves.

There was no real discussion about zone size constraint on the zone
storage BoF. Many discussions happened in the hallway track though.

-- 
Damien Le Moal
Western Digital Research
