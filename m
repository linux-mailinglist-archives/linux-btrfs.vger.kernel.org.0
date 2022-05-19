Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1867452CA32
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 May 2022 05:19:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232990AbiESDT2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 18 May 2022 23:19:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232844AbiESDT0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 18 May 2022 23:19:26 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A93324D623
        for <linux-btrfs@vger.kernel.org>; Wed, 18 May 2022 20:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1652930365; x=1684466365;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=/fjrsnNb+UMSk1eAp1vdCajfjX7evM0A7SUCPImugSk=;
  b=PIVTq+NX/zSlzxo4GSJ8/RDoKVy7uKqI9g2LPrk5jh9x+4si//Uvor6M
   9npfNVzoz7hftMholQqO68rR18/L1yKmJR/1YJ87l4Urm8XdQEzE1q/Vp
   xQ9u98uxwMUxHEaTP+jUHVy6R0jljxuATdcb6ZI7Y37n/1151zl/QLnOf
   LyVscx9pTXzsP6kgdYfJy7l/uWYsES6ohksMIsVRBV5xjDo+8/dMuTSN3
   11JdzLZrRZV0IZEcMPT4TVVo95xMmTGyYzLOEs8M05YZZOaCMa8Y1vmhI
   XXYWbwLtNHCZaVSZJ9+MOssghEs1Y0FN1Ewi9EJmZU7MVO2OVP+Ae6267
   A==;
X-IronPort-AV: E=Sophos;i="5.91,236,1647273600"; 
   d="scan'208";a="312724357"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 19 May 2022 11:19:24 +0800
IronPort-SDR: 6HwmHPSSemI2GeFZY77KBS9qeJEtR7yokI32Yt0Ne8yLl+iyszb5QLdgZoJpiFVccw1ATu9xeg
 Cn2fZZyXH7Qg2IgTcnsu+hgnbDu0X9wowBach30hBuNaF8xJYhwn8GkqsCMj1547nXY4BSBemf
 kI21ubFTpOAdmy/tW7dglvJlWum8ZkIXQ4TErMLC3cbl03s7ydYKZeijBySA02xU6+NnwQg3P5
 eATB4uSp0hWwDSgfGrM/PRK77jWPZ1VKAPd4A8wyQqsw9KqsPxr9s0M1ewZu28kvJniIAMOaTP
 8bJmkIxs91okXbpQ3TN6sFx4
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 May 2022 19:44:55 -0700
IronPort-SDR: qD92Gr4WRFMyDS21WhmN+CM5UAmFGV2CV8ZOwle01hwbmEmcB9rwUv71wwKrq6WOTQgcvpIoQ4
 0Ct1U2YhIcS2Qwz2SYg4H+HAc7/h+7zzaVj4cxZ5Q3lucUdQsvjf/+w3SgNAKLfxbrVBTgCbNr
 vh/B+GZladnHz4XRjwIUzcwpaqw7IreDLXd2V9pEwx9/HKvQENrVM5X6Al4rNSGIAHdi8i9VVl
 zZWKipzSM8gyu4mmFcEPL81qbW6vdhoYJYGkUtW/axEiGYo6D4sd3S5l7k9NLn561XtudCiqHb
 vIw=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 May 2022 20:19:24 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4L3ZpM4PXQz1Rvlx
        for <linux-btrfs@vger.kernel.org>; Wed, 18 May 2022 20:19:23 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1652930362; x=1655522363; bh=/fjrsnNb+UMSk1eAp1vdCajfjX7evM0A7SU
        CPImugSk=; b=nzaWEP3sKrJcNJ3FPCURQIKIvl67f8jA/2wm/ii3lwBWbn3WDZi
        IE/sOdtD7+ND9OHmBJ3aUEGU0W+1DpoA2XmrAamVj/mQ0HVTFq1EL8uyncO3DMS+
        J6dNpyjlz4DKmYidGmO8sIfPQfmUBBnQpWUjWhL8w9LCRAZR9TmFfAodNv2Kwouw
        wDtjAfO6lQ1N7Nuceziw58wMV3A4b6DnW+N3QWimfF9u6RsX5pftmjiOUJ84QuPu
        NIbYasgAX+/cJ6wQy20ztixoasu2bW+bMu0rTHXYzniKQom03aoiKFnWeujXub7H
        jv0tF2/umdPgH5kXJ8hmdql6xR52NXpLPmQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ZZBRljTshjs8 for <linux-btrfs@vger.kernel.org>;
        Wed, 18 May 2022 20:19:22 -0700 (PDT)
Received: from [10.225.163.43] (unknown [10.225.163.43])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4L3ZpJ0qRQz1Rvlc;
        Wed, 18 May 2022 20:19:19 -0700 (PDT)
Message-ID: <69f06f90-d31b-620b-9009-188d1d641562@opensource.wdc.com>
Date:   Thu, 19 May 2022 12:19:18 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [dm-devel] [PATCH v4 00/13] support non power of 2 zoned devices
Content-Language: en-US
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Theodore Ts'o <tytso@mit.edu>, Christoph Hellwig <hch@lst.de>,
        Pankaj Raghav <p.raghav@samsung.com>, axboe@kernel.dk,
        pankydev8@gmail.com, gost.dev@samsung.com,
        jiangbo.365@bytedance.com, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, dm-devel@redhat.com,
        dsterba@suse.com, linux-btrfs@vger.kernel.org
References: <CGME20220516165418eucas1p2be592d9cd4b35f6b71d39ccbe87f3fef@eucas1p2.samsung.com>
 <20220516165416.171196-1-p.raghav@samsung.com>
 <20220517081048.GA13947@lst.de> <YoPAnj9ufkt5nh1G@mit.edu>
 <7f9cb19b-621b-75ea-7273-2d2769237851@opensource.wdc.com>
 <20220519031237.sw45lvzrydrm7fpb@garbanzo>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220519031237.sw45lvzrydrm7fpb@garbanzo>
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

On 5/19/22 12:12, Luis Chamberlain wrote:
> On Thu, May 19, 2022 at 12:08:26PM +0900, Damien Le Moal wrote:
>> On 5/18/22 00:34, Theodore Ts'o wrote:
>>> On Tue, May 17, 2022 at 10:10:48AM +0200, Christoph Hellwig wrote:
>>>> I'm a little surprised about all this activity.
>>>>
>>>> I though the conclusion at LSF/MM was that for Linux itself there
>>>> is very little benefit in supporting this scheme.  It will massively
>>>> fragment the supported based of devices and applications, while only
>>>> having the benefit of supporting some Samsung legacy devices.
>>>
>>> FWIW,
>>>
>>> That wasn't my impression from that LSF/MM session, but once the
>>> videos become available, folks can decide for themselves.
>>
>> There was no real discussion about zone size constraint on the zone
>> storage BoF. Many discussions happened in the hallway track though.
> 
> Right so no direct clear blockers mentioned at all during the BoF.

Nor any clear OK.

> 
>   Luis


-- 
Damien Le Moal
Western Digital Research
