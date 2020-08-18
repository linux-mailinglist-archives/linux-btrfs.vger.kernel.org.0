Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FD0424899E
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Aug 2020 17:23:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727791AbgHRPXF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 18 Aug 2020 11:23:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726673AbgHRPW5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 18 Aug 2020 11:22:57 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4730C061389
        for <linux-btrfs@vger.kernel.org>; Tue, 18 Aug 2020 08:22:56 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id j187so18553581qke.11
        for <linux-btrfs@vger.kernel.org>; Tue, 18 Aug 2020 08:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=w4YNNrwpctJW3na2B9X7kgs44dMug/SaAm0GZP8dLZs=;
        b=Ot/NlEDZxIgZq4oP6NPEI2FXpGp04VsdLctfpRuTA1uBJ72CFd7jLh80jz7nXXD+kl
         GVwSoFPUq2xocERqrst5d8Y1pWI/5w1Lbfkmy2B7GpFXg2vS0KUa5YKscidyA6gvjSM8
         6Ktr+2bMWgmKwQGX+hqtRnhQiz6xvUWJh5ZdYf4ewXdYimOaZY17nmRXTrFg3RIWLcpy
         gmo3R39NrFWk9p66rvRHySLBMpnvVFmofF7On1yRZigBKb8E1/a6BdOYTQai+KdN2yi9
         eeSy81OOOYLFsOKeC0fl7Mn17OZ8LuoZN9q7pxeQL0pIP6eo6yjpTbsAUqqMBj2rDOs4
         /+Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=w4YNNrwpctJW3na2B9X7kgs44dMug/SaAm0GZP8dLZs=;
        b=DMSVxbaYYN2gdr8WY1OfImXR7ezVkSs+QPZo1192k75VS0LiVN83FHEHgMQYK0ZdpZ
         zTyEUSEucX14TeCO4/H5Xq0ONWqI7TDZark916QW/8/avs8q+Mmfc6THd4Wm7sJswcVb
         e9I8Y89gV/0fBOkCKuwDD8nW/K/XAGXniIby085H1w6xc0Mz4+uockypzZrLjzfkAVn5
         x6Vr/bF7K+1kNzXNQrFnkZtQFs9Xr6a6BiRxFN8BYi/RgRMIkakPHo4upOKdVQLqxmOR
         uX5mwWZviYCLhrx84T9QzhRgzrW0OFAF+7c9VVb07rSEA9IpSQ7dG0BCL1G+oVdOCbir
         7/dQ==
X-Gm-Message-State: AOAM532lpt6JhdTwt7y+4IOctlZNBo2FDvyM2GNXzcbGfzhSxCN6/xMS
        Io0wKtZu1MDAwPcKu6XAihmSy2oCF7Nip1B8
X-Google-Smtp-Source: ABdhPJzuJDzM9OQXM9DlKyQSyoeaayOVNDfCk2hXvJcPL1qqfiJHxqcZ+p08Biemtbtos0biFsgrHQ==
X-Received: by 2002:a37:a44:: with SMTP id 65mr17789074qkk.370.1597764176105;
        Tue, 18 Aug 2020 08:22:56 -0700 (PDT)
Received: from ?IPv6:2620:10d:c0a8:11d9::1055? ([2620:10d:c091:480::1:66f8])
        by smtp.gmail.com with ESMTPSA id q16sm21364278qkn.115.2020.08.18.08.22.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Aug 2020 08:22:55 -0700 (PDT)
Subject: Re: [PATCH] btrfs-progs: Make btrfs_lookup_dir_index in parity with
 kernel code
To:     Marcos Paulo de Souza <marcos@mpdesouza.com>, dsterba@suse.com,
        linux-btrfs@vger.kernel.org
Cc:     Marcos Paulo de Souza <mpdesouza@suse.com>
References: <20200818144324.25917-1-marcos@mpdesouza.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <4d6d1e2c-d7fb-3bf9-2d89-0245ce9fe85b@toxicpanda.com>
Date:   Tue, 18 Aug 2020 11:22:54 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200818144324.25917-1-marcos@mpdesouza.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 8/18/20 10:43 AM, Marcos Paulo de Souza wrote:
> From: Marcos Paulo de Souza <mpdesouza@suse.com>
> 
> This function exists in kernel side but using the _item suffix, and
> objectid argument is placed before the name argument. Change the
> function to reflect the kernel version.
> 
> Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef


