Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00F4E124607
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Dec 2019 12:45:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbfLRLpk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 18 Dec 2019 06:45:40 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:52928 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbfLRLpj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 18 Dec 2019 06:45:39 -0500
Received: by mail-pj1-f67.google.com with SMTP id w23so757340pjd.2
        for <linux-btrfs@vger.kernel.org>; Wed, 18 Dec 2019 03:45:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mm2Fp60sM7aWgG3IPyqludUbMTGNyeV8yI8J++FXaXg=;
        b=Wl0P1gjkMuetZ69sbG8AVuSBUrhrP5WOBLL8FcfYbVvxkb2Wsx4BsdFOmGfkpk6SF4
         9+Fh+4Ih4MGB3OepgFJ665EJRtllnfPu38PPD7oXGkWAZ9CGViivfWDecS2hannuPc/9
         gA7992ZT4PaD/9uGeg8ON0VnThGSWMxXyO1Gp2bCGugW3Q1nPD0nzFYJMN3ARUoDQCDd
         c6E1PxYf+bpxo7EbS7U1YXcHm7SMMx/0lQqOu3pFL3fm7HA6VihS7PbQ3MX2bnXqgXXt
         fLO/OEHfVcOgL2/BdnnwRq3NyrFjs7zlGdKr8LUCw84+4/PNWAEHQiYDfVcvXOJPEyIV
         rXiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mm2Fp60sM7aWgG3IPyqludUbMTGNyeV8yI8J++FXaXg=;
        b=IiqPJfini2YlUmOU6yS36+3gqyLaVbH2xhIOgO/oshulRBEAQnz3rzz4EMv8yEEIaG
         hkJlTXKMI3AfPAPHTVYdP90hswzvhDxxaczZxtBXhpgCU5Ysw+Ex/cpDPFKyzm84MtdZ
         +KUn+ka5K6coGC9bT2Qo1+0ANvBxoYhmlgrl/A7G3h6hai0ndvvM3sCJFDbVoNvFZcsf
         NI3v4kJl7rv0IJlPRTB9LIXdHwcH0gE1r+2flaMRGp4ebxeok4v3HgtOvJN03yHXXZoW
         8sfudVR4j5STVGHkzGFW6cPl3adc32RTZJnKL1WSFNDMBOlSD6tGOpuIflxsAvMbremQ
         EMLA==
X-Gm-Message-State: APjAAAX9iBgyFOjnZe7YrpVZiYpedyoeMNz2pBI2eQyCjWuPDwuKmc6k
        qAibiTeWoVcp4G1HB10kkno7WVGx2bc=
X-Google-Smtp-Source: APXvYqx+SEl0gf6/vP8EJHEDL1rcG2Mp7nCiczyIM/oipRT+ZTMNEe9YWUkiMvwLuowsACIOB65loA==
X-Received: by 2002:a17:902:6b03:: with SMTP id o3mr2135239plk.252.1576669538857;
        Wed, 18 Dec 2019 03:45:38 -0800 (PST)
Received: from [192.168.1.145] ([39.109.145.141])
        by smtp.gmail.com with ESMTPSA id z26sm2750804pgu.80.2019.12.18.03.45.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Dec 2019 03:45:38 -0800 (PST)
From:   Anand Jain <anandsuveer@gmail.com>
X-Google-Original-From: Anand Jain <anand.jain@oracle.com>
Subject: Re: [PATCH 10/22] btrfs: add discard sysfs directory
To:     Dennis Zhou <dennis@kernel.org>, David Sterba <dsterba@suse.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Omar Sandoval <osandov@osandov.com>
Cc:     kernel-team@fb.com, linux-btrfs@vger.kernel.org
References: <cover.1576195673.git.dennis@kernel.org>
 <f243ae9b77be6f4db5bcdf848fc4a624f6d5e308.1576195673.git.dennis@kernel.org>
Message-ID: <db4979cc-9d6c-77b8-1358-ae5e9f362f19@oracle.com>
Date:   Wed, 18 Dec 2019 19:45:34 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <f243ae9b77be6f4db5bcdf848fc4a624f6d5e308.1576195673.git.dennis@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 12/14/19 8:22 AM, Dennis Zhou wrote:
> Setup sysfs directory for discard stats + tunables.
> 
> Signed-off-by: Dennis Zhou <dennis@kernel.org>
> Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Anand Jain <anand.jain@oracle.com>


