Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 76CB115485D
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Feb 2020 16:45:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727584AbgBFPpn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 6 Feb 2020 10:45:43 -0500
Received: from mail-qv1-f66.google.com ([209.85.219.66]:44577 "EHLO
        mail-qv1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727060AbgBFPpm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 6 Feb 2020 10:45:42 -0500
Received: by mail-qv1-f66.google.com with SMTP id n8so3034731qvg.11
        for <linux-btrfs@vger.kernel.org>; Thu, 06 Feb 2020 07:45:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=GXOoboWxAJy+/WubpIqUunybPZlmjZWsThqkMfkzeSI=;
        b=bcexwGhor4aRV/DYA/KJwXgbQB/GZChbHnIcFE7E+J8Re4EOKhfyMBl2IPS2i0IdSi
         L2s+7e01dTyrIPKcegHVMacdwMpxQ/Cwbs7jDvJoS44tLJPhfzod6Qnq2Y762Z5XVWD6
         kqFNKF6770Tep6u0AoOjnW+U9hA1JY2lR2y6VW/XZaQXoLxNd7YRi2AC3PLDcjMkUNNp
         0/aPci4EMs0x+CS+P3uCIps6nTpJbzW2M3ncaYJLJ9yvEeOvrHkmhozujUgYHvcml3XP
         RJi92uezk1y9PxhQKmhchSs4DjE6jyg11i+OyAvxN8F4GncLPzmGGsYCwfg9D04q9RlT
         8Ezg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GXOoboWxAJy+/WubpIqUunybPZlmjZWsThqkMfkzeSI=;
        b=I747ZtyT6pFTPp++1Q6MxjsmygW9pwvP+zcNK/ANsDKL00jMbhqfbMARKhh4M4lxNh
         QUHwsywhFzNO7FKhdDClE+x7TQQOsQy1y1G1+x72N2NndVD6aGvw0xwbA7UZyq7oZukO
         vAAyUIHSMODeGyvrYZ45whKB6F1X4pY10J7VXGPf2O/Z1zjQInfla6hRljW4wzcHzvGz
         p/38VzrYTTDQP1nvsQ95p6XzTaY8/QSEL4ruBiCeumSGh+8+ndknbm+OGKdWTq0gc4E3
         xMKATjK4W7Rumed5g2vAnoAsvZBYSiehuooBPXAMq0FKzKCWBQl/E8GGrmQa/T6h1yiT
         wy6A==
X-Gm-Message-State: APjAAAXa2nx2YGFGMukeYmFOZ2iwKFWFNLh3YvJcD8IFU/r6VIkLxYy+
        p6mxGx/oUlqpbwOhj0hof4pAgX0ukHw=
X-Google-Smtp-Source: APXvYqx3uBqAQ6tiQznxfuNER4XJS4AUQFP3g/1PDwEX0d2+tsqTyj+BGcJLYFQgOp3YMWV8ThKMkg==
X-Received: by 2002:a0c:8605:: with SMTP id p5mr2883233qva.109.1581003940677;
        Thu, 06 Feb 2020 07:45:40 -0800 (PST)
Received: from [192.168.1.106] ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id y28sm1614571qkj.44.2020.02.06.07.45.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Feb 2020 07:45:40 -0800 (PST)
Subject: Re: [PATCH] btrfs: move root node locking helpers to locking.c
To:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <20200205162651.32110-1-dsterba@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <2c9c009b-6f93-6b4e-81a8-d3d81e9dd6d3@toxicpanda.com>
Date:   Thu, 6 Feb 2020 10:45:39 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200205162651.32110-1-dsterba@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2/5/20 11:26 AM, David Sterba wrote:
> The helpers are related to locking so move them there, update comments.
> 
> Signed-off-by: David Sterba <dsterba@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
