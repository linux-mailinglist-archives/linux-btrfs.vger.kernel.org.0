Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D3D46124606
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Dec 2019 12:45:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbfLRLph (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 18 Dec 2019 06:45:37 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:52922 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbfLRLph (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 18 Dec 2019 06:45:37 -0500
Received: by mail-pj1-f65.google.com with SMTP id w23so757276pjd.2
        for <linux-btrfs@vger.kernel.org>; Wed, 18 Dec 2019 03:45:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fZloymcvND4bhKwoBxRj8BanP/qrzyNmq0WWxyuWZ1g=;
        b=pqdTsaV+Lmi+8uZeVGMQ6pv2HXj0aBkFMGb2cHuXaOiFA3wke0zKDpIpKWBNh6j8fb
         CWYmpxRQpFlS49G8uZ6GgaXkvlVd0So6J/sLNqWiLpFaYT9uEOgQCbSvaplfeyQkb1SP
         ICu7/QdRQ7Q4f46dX73KM1qSrvfwvR+Ohnx40yK3oYW5fZM+dNILn/Klu5QHxtvriOaz
         FBtWMpXZYXYNwoSdbiO2AdnYVwtopinnlaRxTlDtKdTadiE6WJcfIIw3WcYTqkry0A8X
         r6qU6CvHR7sIlWQxDoAijNxjpgKyeQdDEa9yYBV2yWVIZj7YadfY+c5BcrfBItLNbkBA
         +n4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fZloymcvND4bhKwoBxRj8BanP/qrzyNmq0WWxyuWZ1g=;
        b=CWc6UUCA/Ti4LGqbTjckuxYX/vO8Pxv37wlSvEhoOqWOVyaHVtMjQKhsDY5K5Z8A2s
         DSkNFt1Q95gTxKb3m0hh5FKQ8UpopzwcbQWTX6qnvzMJczbOx5CR7SMpqltlZuzctt/S
         lRb1AAaoaFinreUeDZhXGewtKEKvUf7quHBY5BajEDJWoQxEw+AFLWXavcaREEnv2HVF
         VYt+8uxYXxMb6rJczwhl2+x525FrWXLs39p+9WaiC4VgwuGOxl2A1ApJESMBjFPsIS1L
         dSmfzgIj0ZXwWjPFdfBATA8mNuzBBnlyzsxW/5mg6sPlDRDKsKhIQvgeBAuC6owCkmT8
         zAOg==
X-Gm-Message-State: APjAAAUNhoEabctucb/66g9qWinZMMvJbSgrtJWvaeozIXWpA0MRzX2d
        FI9Nlf292upBPrlgQryDc7XeHzdDkd4=
X-Google-Smtp-Source: APXvYqzbPZvJ+4xVgqo43epmCq6zqf4ne2EP2updpq6hFmpOsIpCm192lnJUo1vIoSJRDye8Fqwr6w==
X-Received: by 2002:a17:90a:26ab:: with SMTP id m40mr2354871pje.42.1576669536008;
        Wed, 18 Dec 2019 03:45:36 -0800 (PST)
Received: from [192.168.1.145] ([39.109.145.141])
        by smtp.gmail.com with ESMTPSA id f8sm2965947pfn.2.2019.12.18.03.45.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Dec 2019 03:45:35 -0800 (PST)
From:   Anand Jain <anandsuveer@gmail.com>
X-Google-Original-From: Anand Jain <anand.jain@oracle.com>
Subject: Re: [PATCH 09/22] btrfs: make UUID/debug have its own kobject
To:     Dennis Zhou <dennis@kernel.org>, David Sterba <dsterba@suse.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Omar Sandoval <osandov@osandov.com>
Cc:     kernel-team@fb.com, linux-btrfs@vger.kernel.org
References: <cover.1576195673.git.dennis@kernel.org>
 <c61536b8a5b88101480d33815089cf656748a58b.1576195673.git.dennis@kernel.org>
Message-ID: <e1384e1d-84ca-c18c-b58b-d5c22b9a5a71@oracle.com>
Date:   Wed, 18 Dec 2019 19:45:26 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <c61536b8a5b88101480d33815089cf656748a58b.1576195673.git.dennis@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 12/14/19 8:22 AM, Dennis Zhou wrote:
> Btrfs only allowed attributes to be exposed in debug/. Let's let other
> groups be created by making debug its own kobject.
> 
> This also makes the per-fs debug options separate from the global
> features mount attributes. This seems to be needed as
> sysfs_create_files() requires const struct attribute * while
> sysfs_create_group() can take struct attribute *. This seems nicer as
> per file system, you'll probably use to_fs_info().
> 
> Signed-off-by: Dennis Zhou <dennis@kernel.org>
> Reviewed-by: Josef Bacik <josef@toxicpanda.com>


Reviewed-by: Anand Jain <anand.jain@oracle.com>

