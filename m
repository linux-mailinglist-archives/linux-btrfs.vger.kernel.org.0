Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3E745AA52D
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Sep 2022 03:39:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234608AbiIBBi7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 1 Sep 2022 21:38:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231764AbiIBBi5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 1 Sep 2022 21:38:57 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94B6991D2F
        for <linux-btrfs@vger.kernel.org>; Thu,  1 Sep 2022 18:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1662082736; x=1693618736;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=fkjhkfssw14V/+Vwqu+T+FisZXpvkRyRc6YH1qGQjpc=;
  b=oNPmRQx5gY510vIxWIcPe86ocQ27vb8EKCt0ZfQrI2SA1q0cw360WeXb
   GG0GvE5fMvf5v7GZ4YMVfJL26WIgzBGWIBWEnip6jEMNJuzHFA6f5cppz
   nJXhGTJ/L1T8zrwkzmxfQJvmIwRwiPFvotSI1EE1+t64Uz/vrv5O+uVNN
   FrX62Zfjfhgz6VotxEwns+A1Orl/P0UI6yvmPZ7fEyvvoDQUIrFdbnBxb
   3y7UQPOmWEhT66XPn/MV1tyGY3Zbf1x2hd5yVVkqmB2icLR3zxzTRSOBU
   P6lrV6CvRwKicgYbZys6frqYpXuCQomQL5wVKTowCziVs6/uF12XAmRmF
   A==;
X-IronPort-AV: E=Sophos;i="5.93,281,1654531200"; 
   d="scan'208";a="215449438"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 02 Sep 2022 09:38:55 +0800
IronPort-SDR: hak4GNvCH8+sPSuoSNzS9h0BApA6klLRAPE++UrYI0MZBGZUJm2BZvMuaZMgl1kWRLY2nr54p/
 2Kw4Srblui/K1YpFu5yukdTGYvAG0tMTmUK4pTBzgYRYv7xUyszGaO1xL8jkMDovboFxNvFu6K
 9EsmIaD7RNMFnNOHHFW3MB3wdXBp8yS/pDsppNfFvr2mDBBNXIvI6dIyXFXFE6WluN0Ko47mjl
 freS6NzLm2y4bOSIKdou8FygFy0X+BAWrx7fV5f03ZQknSmQNmVxFB0nlzintKZ7tYeCIXQoK7
 5xod4f5cWwEXyVpfd4pHuRw4
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 01 Sep 2022 17:59:24 -0700
IronPort-SDR: Maiw73BvteYhTP5ijQul7utvqpjpqah6QWxMqyUDDQK7iCEDFJZxQQVNgihF1lo1uemVPnsV/k
 UtBa4dQpOEpCHlbB57rt40+Jo/JAIIfDfZYVyJOQETw9LeUBjiAAgYMjuHWkOGNkgdCPk7k9NN
 JZHPwJi8ERjXFRiTemFQQsIcax5nxGkfpJF9W8PbSBYguUMOnntVaEWMBzI5gn7Jtxl70sNcor
 n/LzQn6lrMFmKcU5Ig+IraEIPg0qKRVX7E9Hqosuwhr6kk9nzUhwezgKF58OzciM+5MFSRJUjk
 DuY=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 01 Sep 2022 18:38:56 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4MJgYW1tlxz1Rwtl
        for <linux-btrfs@vger.kernel.org>; Thu,  1 Sep 2022 18:38:55 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1662082734; x=1664674735; bh=fkjhkfssw14V/+Vwqu+T+FisZXpvkRyRc6Y
        H1qGQjpc=; b=oDNr1Rs28CmLnSi10thx8HyLuiOkOC/iTGVJ3LM6oIcTWTypKtk
        GEy3MdWhdq/z8QZCv0tXAk8htvcb9A4CF+zS+Di6l4SalNwMVbOHfXHk8k4mTy+a
        /2qWrw6FlpeQzKFf7JOaWqpHoRfpSNDWmvq0rh1Ri8Lq6Amtp1EnsQpXYC6b5wQj
        2VnvPgLhiCUz4cZ7EOU98fdXUgDpY3hvst6YiZhdbZpUl43gpId9mveZ4DDan7oY
        UUEYV212QWjTaL0yZ7HMvElMxJ9xwDNr5NOfGgmBxh/VRh7ZCKuMp7rjRS8F4Sed
        6U9Ir5GpDSYYUaxQTddOJsKnUsqcEB7KkLQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id XYOH3QIhsi7L for <linux-btrfs@vger.kernel.org>;
        Thu,  1 Sep 2022 18:38:54 -0700 (PDT)
Received: from [10.225.163.56] (unknown [10.225.163.56])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4MJgYS2ngTz1RvLy;
        Thu,  1 Sep 2022 18:38:52 -0700 (PDT)
Message-ID: <c2e15bee-cd4d-9699-621d-986029f337b6@opensource.wdc.com>
Date:   Fri, 2 Sep 2022 10:38:50 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH 17/17] iomap: remove IOMAP_F_ZONE_APPEND
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Qu Wenruo <wqu@suse.com>, Jens Axboe <axboe@kernel.dk>,
        "Darrick J. Wong" <djwong@kernel.org>, linux-block@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20220901074216.1849941-1-hch@lst.de>
 <20220901074216.1849941-18-hch@lst.de>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220901074216.1849941-18-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 9/1/22 16:42, Christoph Hellwig wrote:
> No users left now that btrfs takes REQ_OP_WRITE bios from iomap and
> splits and converts them to REQ_OP_ZONE_APPEND internally.

Hu... I wanted to use that for zonefs for doing ZONE APPEND with AIOs...
Need to revisit that code anyway, so fine for now.

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/iomap/direct-io.c  | 10 ++--------
>  include/linux/iomap.h |  1 -
>  2 files changed, 2 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> index 4eb559a16c9ed..9e883a9f80388 100644
> --- a/fs/iomap/direct-io.c
> +++ b/fs/iomap/direct-io.c
> @@ -217,16 +217,10 @@ static inline blk_opf_t iomap_dio_bio_opflags(struct iomap_dio *dio,
>  {
>  	blk_opf_t opflags = REQ_SYNC | REQ_IDLE;
>  
> -	if (!(dio->flags & IOMAP_DIO_WRITE)) {
> -		WARN_ON_ONCE(iomap->flags & IOMAP_F_ZONE_APPEND);
> +	if (!(dio->flags & IOMAP_DIO_WRITE))
>  		return REQ_OP_READ;
> -	}
> -
> -	if (iomap->flags & IOMAP_F_ZONE_APPEND)
> -		opflags |= REQ_OP_ZONE_APPEND;
> -	else
> -		opflags |= REQ_OP_WRITE;
>  
> +	opflags |= REQ_OP_WRITE;
>  	if (use_fua)
>  		opflags |= REQ_FUA;
>  	else
> diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> index 238a03087e17e..ee6d511ef29dd 100644
> --- a/include/linux/iomap.h
> +++ b/include/linux/iomap.h
> @@ -55,7 +55,6 @@ struct vm_fault;
>  #define IOMAP_F_SHARED		0x04
>  #define IOMAP_F_MERGED		0x08
>  #define IOMAP_F_BUFFER_HEAD	0x10
> -#define IOMAP_F_ZONE_APPEND	0x20
>  
>  /*
>   * Flags set by the core iomap code during operations:

-- 
Damien Le Moal
Western Digital Research

