Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A924F55C8BF
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Jun 2022 14:55:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344475AbiF1MhH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 28 Jun 2022 08:37:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230292AbiF1MhG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 28 Jun 2022 08:37:06 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C8CD2ED77
        for <linux-btrfs@vger.kernel.org>; Tue, 28 Jun 2022 05:37:06 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id h9-20020a17090a648900b001ecb8596e43so12472897pjj.5
        for <linux-btrfs@vger.kernel.org>; Tue, 28 Jun 2022 05:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:to:cc:references
         :from:in-reply-to:content-transfer-encoding;
        bh=10KqDo3l+oRJpK2nuoOEd70Fhsb76bpSh2Wi9097fMo=;
        b=KE+ozFhqZIqAqsS1Jh2RdtT2CWGNBxIbpoLAX4HrPe9rZNnn2xFMW9Bl54M379GyYp
         dgqARDamfcOievZuyNl7qBkLlp1MXiWbHiPuRa/MF1Z9ChSkECyDfOn6WrJBWjVZvL+/
         q2yyPgy3LQRmetxOdbj8UODUuzJnAL2d3DBxGaq/rRFCb0JCa6LOiOMxrAmCxg/ZO1Qr
         wJRKoOlcd9qArFH0/8E7F0uxyLQ/kOJHmlcFnH69Sw00Bri2w7giJBz69z9pcUYBZGej
         g5C2HFAN2BeZtvSpH7AIJOnnUOyLGUkP6MuKAG/O2/oinXoKRwZ/Bf+Ds6IaF6UJuzAX
         meVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :to:cc:references:from:in-reply-to:content-transfer-encoding;
        bh=10KqDo3l+oRJpK2nuoOEd70Fhsb76bpSh2Wi9097fMo=;
        b=EyK4XcU/+ch+doLNIxnI51v/+nYZiv/a5a6X9p5+2QPI1gsTh3BDXTQXCyCqJdjc6F
         mM7T++ku3H4yIFlnJsdlbqXz8g+4j3d///I/JVC/mCtRkrRrhldRiSv9hPUt4NXyTHzq
         kKWFK0Ctwqvr2TCyuO1wfN7V0g293Z9F/BxfYu7CvbuB7u2qEOCH5w/wixwAKCLtQ4Zr
         KbfVZro4dv4elJjFDqU/+o1TOCzzH5v0Ynhi7jXNWT7moA2VcHZPujLYPNdFPjOsRVr6
         UTrqqt9rvcIGXmnmV1qbVL9KLDrZ02hloOg4mYM9bpQQTqceO/+ur03uvPgEUA6sAK00
         sgIQ==
X-Gm-Message-State: AJIora8NDzE4Rvcj9CLNXB2JzFkQgv8w/p62i6P5Fy9USLuAZ9p1SKJH
        Qgi1kPnw2JdxKfTZU4oVoOs=
X-Google-Smtp-Source: AGRyM1v1LOR56VlboBTcD6o/LS58rokcZdQDekHNJuY4yqG58mMpDMcldLcOYlL8NnkgxVKbSDTyvw==
X-Received: by 2002:a17:903:18f:b0:16a:5c43:9a85 with SMTP id z15-20020a170903018f00b0016a5c439a85mr4715326plg.122.1656419825563;
        Tue, 28 Jun 2022 05:37:05 -0700 (PDT)
Received: from [127.0.0.1] ([103.215.126.123])
        by smtp.gmail.com with ESMTPSA id g9-20020aa78749000000b005254ad7ba0fsm9582675pfo.171.2022.06.28.05.37.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jun 2022 05:37:05 -0700 (PDT)
Message-ID: <6f958407-0c3c-1cd6-ced2-08bc9c267d17@gmail.com>
Date:   Tue, 28 Jun 2022 20:36:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH RFC 2/8] fs: always get the file size in _fs_read()
To:     Qu Wenruo <wqu@suse.com>, u-boot@lists.denx.de
Cc:     marek.behun@nic.cz, linux-btrfs@vger.kernel.org,
        linux-erofs@lists.ozlabs.org, trini@konsulko.com,
        joaomarcos.costa@bootlin.com, thomas.petazzoni@bootlin.com,
        miquel.raynal@bootlin.com
References: <cover.1656401086.git.wqu@suse.com>
 <cd417bc9dc4b44c4ac8d98f146e47c98cf4aac5a.1656401086.git.wqu@suse.com>
From:   Huang Jianan <jnhuang95@gmail.com>
In-Reply-To: <cd417bc9dc4b44c4ac8d98f146e47c98cf4aac5a.1656401086.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi, wenruo,

在 2022/6/28 15:28, Qu Wenruo 写道:
> For _fs_read(), @len == 0 means we read the whole file.
> And we just pass @len == 0 to make each filesystem to handle it.
>
> In fact we have info->size() call to properly get the filesize.
>
> So we can not only call info->size() to grab the file_size for len == 0
> case, but also detect invalid @len (e.g. @len > file_size) in advance or
> truncate @len.
>
> This behavior also allows us to handle unaligned better in the incoming
> patches.
>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>   fs/fs.c | 25 +++++++++++++++++++++----
>   1 file changed, 21 insertions(+), 4 deletions(-)
>
> diff --git a/fs/fs.c b/fs/fs.c
> index 6de1a3eb6d5d..d992cdd6d650 100644
> --- a/fs/fs.c
> +++ b/fs/fs.c
> @@ -579,6 +579,7 @@ static int _fs_read(const char *filename, ulong addr, loff_t offset, loff_t len,
>   {
>   	struct fstype_info *info = fs_get_info(fs_type);
>   	void *buf;
> +	loff_t file_size;
>   	int ret;
>   
>   #ifdef CONFIG_LMB
> @@ -589,10 +590,26 @@ static int _fs_read(const char *filename, ulong addr, loff_t offset, loff_t len,
>   	}
>   #endif
>   
> -	/*
> -	 * We don't actually know how many bytes are being read, since len==0
> -	 * means read the whole file.
> -	 */
> +	ret = info->size(filename, &file_size);

I get an error when running the erofs test cases. The return value isn't 
as expected
when reading symlink file.
For symlink file, erofs_size will return the size of the symlink itself 
here.
> +	if (ret < 0) {
> +		log_err("** Unable to get file size for %s, %d **\n",
> +				filename, ret);
> +		return ret;
> +	}
> +	if (offset >= file_size) {
> +		log_err(
> +		"** Invalid offset, offset (%llu) >= file size (%llu)\n",
> +			offset, file_size);
> +		return -EINVAL;
> +
> +	}
> +	if (len == 0 || offset + len > file_size) {
> +		if (len > file_size)
> +			log_info(
> +	"** Truncate read length from %llu to %llu, as file size is %llu **\n",
> +				 len, file_size, file_size);
> +		len = file_size - offset;
Then, we will get a wrong len in the case of len==0. So I think we need 
to do something
extra with the symlink file?

Thanks,
Jianan
> +	}
>   	buf = map_sysmem(addr, len);
>   	ret = info->read(filename, buf, offset, len, actread);
>   	unmap_sysmem(buf);

