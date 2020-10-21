Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B23AC294EF5
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Oct 2020 16:44:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2443711AbgJUOow (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Oct 2020 10:44:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2442516AbgJUOow (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Oct 2020 10:44:52 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE11CC0613CE
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Oct 2020 07:44:51 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id q26so2299211qtb.5
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Oct 2020 07:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=lac8ohleDm2BZvt7AzLpok37UMhebIgD4Ce0TOch1pY=;
        b=LSVU6LsMCmIDOckHCddRQvtH57AxsKE3RJ+oIaxOj5E0iaUmA9paeueXu+9yfGMC4s
         vzGiBkBqNi+9lsW55qTz9pF5KBCSS0ucTpvZ0Gqu5PCFcSTwLMt7Lfp9S8oU3r+/0QQq
         R+eutlxLqmnqtrRYll0hNQnRndf1S3iUPoVc2oBnjSn/+1eSuEOoJ6BEP5Q90sUG7q98
         d9Ths1yFKEdhqYsdux0TlCkXXBoWHRInNChgD6A1ed3iPjud8Z+YDsGEUiWi97wDeZ2J
         MYrPVsZtbzDO2RXg5rY1Ji/+cdeXZIi3FyiUS8eCFz5Pse2LVdnFdOxn8MbjFry+fi71
         IxIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lac8ohleDm2BZvt7AzLpok37UMhebIgD4Ce0TOch1pY=;
        b=GtdEiATnJEhjUwidIEFJk/J+jizACPeYVE/ovHFtElWIFoFlUTQB1gkIB7PLiJtq4g
         5NFkkyQADylu2BfyJ+Sm/h5g5rEchQ+BVlwzfELlVAnTebGL0LFx6Xiq5zszzTaN2kU8
         uigL2hWbqvjauBvWSb7k7UZyZivjtwX10MI6/LRKZ4/X/LURz2XvpHBkWpPVKEhIi8pa
         l8NyVmef1TwChryIyl+CkZXoMYvUs3ktzu0fmNHHmIkpC/NAyVx+L0a6AF7jMCw0Bt7u
         UhmRZFRJYiVNuLtjAzhLo1UGoKZP5apXlRBuuMcHfbkU+KZZo26aDd4doeE4J6QEao1v
         P5xA==
X-Gm-Message-State: AOAM533rBYpNnVjx06bZ0DSIT7gBm6tKlLFnAZfxoOUHqExC4D8K5cCj
        DqUYBR4eeZfRbE8UV39QsQ3qHA==
X-Google-Smtp-Source: ABdhPJw6ftBF8STZst2wCW6il0OEt/PxorVbW5EM285O6Vwg0bVzZJm2iuH3fBwSwvUvkxJmVIGd+A==
X-Received: by 2002:ac8:c4e:: with SMTP id l14mr3485455qti.149.1603291489751;
        Wed, 21 Oct 2020 07:44:49 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id 123sm1388850qkj.85.2020.10.21.07.44.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Oct 2020 07:44:48 -0700 (PDT)
Subject: Re: [PATCH v8 1/3] btrfs: add btrfs_strmatch helper
To:     Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com
References: <cover.1602756068.git.anand.jain@oracle.com>
 <7418ae34e5a4cc7d110eed756d9e37c5630ec568.1602756068.git.anand.jain@oracle.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <e599667f-af00-7cbf-65c8-fb1151e66411@toxicpanda.com>
Date:   Wed, 21 Oct 2020 10:44:47 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.3.2
MIME-Version: 1.0
In-Reply-To: <7418ae34e5a4cc7d110eed756d9e37c5630ec568.1602756068.git.anand.jain@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 10/20/20 10:02 AM, Anand Jain wrote:
> Add a generic helper to match the golden-string in the given-string,
> and ignore the leading and trailing whitespaces if any.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> Suggested-by: David Sterba <dsterba@suse.com>
> ---
> v5: born
> 
>   fs/btrfs/sysfs.c | 23 +++++++++++++++++++++++
>   1 file changed, 23 insertions(+)
> 
> diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
> index 8424f5d0e5ed..eb0b2bfcce67 100644
> --- a/fs/btrfs/sysfs.c
> +++ b/fs/btrfs/sysfs.c
> @@ -863,6 +863,29 @@ static ssize_t btrfs_generation_show(struct kobject *kobj,
>   }
>   BTRFS_ATTR(, generation, btrfs_generation_show);
>   
> +/*
> + * Match the %golden in the %given. Ignore the leading and trailing whitespaces
> + * if any.
> + */
> +static int btrfs_strmatch(const char *given, const char *golden)
> +{
> +	size_t len = strlen(golden);
> +	char *stripped;
> +
> +	/* strip leading whitespace */
> +	stripped = skip_spaces(given);
> +
> +	if (strncmp(stripped, golden, len) == 0) {
> +		/* strip trailing whitespace */
> +		if (strlen(skip_spaces(stripped + len)))
> +			return -EINVAL;

if ((strncmp(stripped, golden, len) == 0) &&
     (strlen(skip_spaces(stripped + len)) == 0))
	return 0;

Thanks,

Josef
