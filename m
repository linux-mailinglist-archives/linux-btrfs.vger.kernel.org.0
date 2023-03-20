Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 552FC6C0B4F
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Mar 2023 08:26:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230005AbjCTH0N (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 20 Mar 2023 03:26:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjCTH0L (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 20 Mar 2023 03:26:11 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 335201CAE4
        for <linux-btrfs@vger.kernel.org>; Mon, 20 Mar 2023 00:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1679297169; x=1710833169;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=PznhUX2rDF8uhJla7kd2cwVnZx5w5yiNB4r5BQcdnfM=;
  b=nv+UpsTzuexcheOatHRuzIXoGBFE2bCC8Y0HdE9hsJtvLQn/RcPS9E3c
   uXuQmTbq1FYvRknl7+LG/UIQCNxO9AwCZme6ADDnesJpD2lrwGKrZYdN9
   MYleDw6y9/sX9d376oNTWC8T6wCvyK70Bbdvv9N6R2rMrj6u/RyPV6VkR
   C9X3MMsM0OzIphp90Stii47GxTGduveTcXRztAYlpYE+ZDQAcEyl1RCJg
   acRKtEDR246Rv6oQkO/sLFTIHh62RV2wBTmhc9gOSaVkUcOSvw0b/BQH9
   nxD+6mUgkr6gBERKRJjZ1l0bORnYSJgk4c67MzD7vUKcCmYBSvtiiYrWP
   Q==;
X-IronPort-AV: E=Sophos;i="5.98,274,1673884800"; 
   d="scan'208";a="330429277"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 20 Mar 2023 15:26:09 +0800
IronPort-SDR: 4O+lWKlx/b9A9CcU7qxyy6JfrH2OeTYSpzUeYCmV0zUsq25paPA7fUdSJjWlcfclqae7UuL1l1
 XgKnFAaZSMI7InME3fL4cgsYSOToIZzLU0pIn90kvez0XR+HUelTCJX6t+bOBkKfcNlNwkcL1a
 txBwnfwqfgRRX6HGrvddiZJ9sPfJIB1DGRuQaBpWUQYJWeoPHkIHzLToszdfKdyb3HnMOUTaxF
 bXUzc9kDgTeeyT3Y+W+FuChybssIOuwF8R/AnRHxEZzxkMJiyM4O0Hihn7lraS3H6Bu4EyrSwE
 ASs=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Mar 2023 23:42:29 -0700
IronPort-SDR: UhhneLVKDpLWls6H3tfqXUCt0dI6wreupjGnXq54KiZLPBLipkPrE7fJNfAj92Ho+K6PXVKOIn
 Sn9zbmWTrC6BvUskDjkAyK23fkALd6I2PVf6lkzdSAKjm7GfZA2UKk3yNn11FRlledY210XjL1
 8lVZQtGOUkvBpFNmvXniIHDBJ3UpSBFoTJwjKIzvJJEHEg8IY4nPs85EngDudBbEp3/gvtHvqP
 abPjsR4CVXRPD6B7GuVoa4gTpz1GsXaW6XuNd4gqtS3zoPIsqlSfTuYioF4xS2GyVkraO4Hy2Z
 Dy4=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Mar 2023 00:26:09 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Pg5rK1Zc8z1RtVp
        for <linux-btrfs@vger.kernel.org>; Mon, 20 Mar 2023 00:26:09 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1679297167; x=1681889168; bh=PznhUX2rDF8uhJla7kd2cwVnZx5w5yiNB4r
        5BQcdnfM=; b=tEhaQ1QWlYcUATSxgbmC1Irjhy1iyCOONUyaK4zHJkCmEPDGLER
        2bZXp7uXoeN6RX3JCuajZywhfAJDoiQCLYJkObCkGj6gN3IG0YhXYgKyKzEh7jWM
        OqPz8kTfiyiU5LFataQwHHb0Sbff8iMojaicjEFH4uoIbhjfsq9W6NYYGCPzEgUr
        BAxViofGRKnKh0NBhnXzZWgoPGthoEyR7qdFamLve7TMT+hPEtcz8xU+LdNaTGxO
        NpcEOGrr0JDR74v3n42n2iISL8Vz0bKzh+gj1hMK7lBnM8bCMoI86PFZva038aHw
        bO7IcaXdozRFOsyM3oQ1/Qtj86vrWfVdz2g==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Bfc9Y5Q89xTy for <linux-btrfs@vger.kernel.org>;
        Mon, 20 Mar 2023 00:26:07 -0700 (PDT)
Received: from [10.225.163.91] (unknown [10.225.163.91])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Pg5rB164vz1RtVm;
        Mon, 20 Mar 2023 00:26:01 -0700 (PDT)
Message-ID: <982b6aa9-4adb-acef-d9d7-9a1764a66213@opensource.wdc.com>
Date:   Mon, 20 Mar 2023 16:26:00 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2, RESEND 01/10] kobject: introduce kobject_del_and_put()
Content-Language: en-US
To:     Yangtao Li <frank.li@vivo.com>, clm@fb.com, josef@toxicpanda.com,
        dsterba@suse.com, xiang@kernel.org, chao@kernel.org,
        huyue2@coolpad.com, jefflexu@linux.alibaba.com, jaegeuk@kernel.org,
        trond.myklebust@hammerspace.com, anna@kernel.org,
        konishi.ryusuke@gmail.com, mark@fasheh.com, jlbec@evilplan.org,
        joseph.qi@linux.alibaba.com, richard@nod.at, djwong@kernel.org,
        naohiro.aota@wdc.com, jth@kernel.org, gregkh@linuxfoundation.org,
        rafael@kernel.org
Cc:     linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-erofs@lists.ozlabs.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-nfs@vger.kernel.org,
        linux-nilfs@vger.kernel.org, ocfs2-devel@oss.oracle.com,
        linux-mtd@lists.infradead.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <e4b8012d-32df-e054-4a2a-772fda228a6a@opensource.wdc.com>
 <20230320071140.44748-1-frank.li@vivo.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20230320071140.44748-1-frank.li@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 3/20/23 16:11, Yangtao Li wrote:
> Hi filesystem maintainers,
> 
>> Hard to comment on patches with this. It is only 10 patches. So send everything please.
> 
> If you are interested in the entire patchset besides Damien,
> please let me know. I'll resend the email later to cc more people.

Yes, I said I am interested, twice already. It is IMPOSSIBLE to review a patch
without the context of other patches before/after said patch. So if you want a
review/ack for zonefs, then send the entire series.

> 
> Thx,
> Yangtao

-- 
Damien Le Moal
Western Digital Research

