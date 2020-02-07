Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A0BC155091
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Feb 2020 03:11:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727478AbgBGCLC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 6 Feb 2020 21:11:02 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:36518 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727028AbgBGCLC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 6 Feb 2020 21:11:02 -0500
Received: by mail-qk1-f195.google.com with SMTP id w25so785893qki.3
        for <linux-btrfs@vger.kernel.org>; Thu, 06 Feb 2020 18:11:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=GohM5j4mI7JcEUmByle4atLeR2+HlAMwdV2lrgFqoU4=;
        b=GL7K3S51MuifAY+a5v4KEKjb5Mt8ncrz3FW5AR8lJxh4RRI9nnJGtdZW8pMsIy7/W1
         GwT9zAbtU4v7Ubz1ajfR8FQYIh+TvuDATbj4tyI31NOeFnCu1uY5KOpEX6t/s3/JcJQB
         yEtUHrdHelAbmFXWgLKSU6DCT7hiGUyRaJ4m0eAMMhytQkSHFAjrOrJ0sZPTAv+vHxnL
         GRDC/rDuwmZKv6TosGs5fc/wUaRzdUD5CxtneY4KcAmtTayr83E3g0pPW4UC7BWbjQ9o
         Nu30NIKyZ/Mg7tQevteHeZMXhm+1wPCPW4dUrfCNbR12b0CW+eJPYT46sjV+PsgiU71P
         Dnjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GohM5j4mI7JcEUmByle4atLeR2+HlAMwdV2lrgFqoU4=;
        b=Cj0HWh70MraBDWESHleS0pCODF3lc7msVqZXlPQGw6QfWTMnP9A0xo6RgXEtfubBEd
         QRAFS5R3o1cikFE/nW68jZtxwJVzbaF+y+l9S25Ab2V9NJ57JTQhAyU7Oqi4R2zz0QNa
         pwISzeywaLP/vIsHgngFaxCzHhzwP0o8lMekLeC0ssOvO5Q2W//MJMQPe3+SmsLHPZeM
         GdXzkHS8QbtrCqgyzGZLNp1fLxLVUmaYiB7znmIy2aYQ4MV7Qyqz5H71rc1ndPuN/98o
         DiS7Pmir0xHL+yBRgb+D5fZTRd0fvH1HePM4ZCmkaqnIhNNjHV/gSf7OWREfEYgjbnQR
         TnjA==
X-Gm-Message-State: APjAAAXQ/rN3an7NqqSj037UphNitjFm070E/nZkFDXh8wt1okagZJmj
        /L4y53EQ0fF8lwnQSnGIR9dZfyboKIk=
X-Google-Smtp-Source: APXvYqxFptk9pQSSnuaAFg60/m6rsUIjV0fHObqrs+cVKW5h2WsKnlKWJSoDXpyAZu+gPGxd6a/a/Q==
X-Received: by 2002:a37:8ec7:: with SMTP id q190mr5181076qkd.412.1581041460901;
        Thu, 06 Feb 2020 18:11:00 -0800 (PST)
Received: from [192.168.1.106] ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id d18sm596126qke.75.2020.02.06.18.10.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Feb 2020 18:11:00 -0800 (PST)
Subject: Re: [PATCH 3/3] fstests: btrfs/022: Add debug output
To:     Qu Wenruo <wqu@suse.com>, fstests@vger.kernel.org,
        linux-btrfs@vger.kernel.org
References: <20200207015942.9079-1-wqu@suse.com>
 <20200207015942.9079-4-wqu@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <e734fda2-04f9-0dc8-ae6c-88ce415a95f1@toxicpanda.com>
Date:   Thu, 6 Feb 2020 21:10:59 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200207015942.9079-4-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2/6/20 8:59 PM, Qu Wenruo wrote:
> When btrfs/022 fails, its $seqres.full doesn't contain much useful info
> to debug.
> 
> This patch will add extra debug, including subvolid and full "btrfs
> qgroup show" output.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
