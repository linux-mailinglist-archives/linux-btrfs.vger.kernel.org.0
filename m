Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E99E72FC089
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Jan 2021 21:03:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729701AbhASTqr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 19 Jan 2021 14:46:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728908AbhASTpQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 19 Jan 2021 14:45:16 -0500
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6DA6C0613C1
        for <linux-btrfs@vger.kernel.org>; Tue, 19 Jan 2021 11:44:34 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id c7so23097594qke.1
        for <linux-btrfs@vger.kernel.org>; Tue, 19 Jan 2021 11:44:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vOfKAt2EOhHolKwG7ZmDLU43lxbEY1uJX5ZWABu31QQ=;
        b=pMUr9siaWJXwo0U62hL9ugQ26BCB/zUrFluKWBiZsuaj2ojlLHOqRTDia+HcC4IYxr
         MN6Z3zwqCzrCrCtzKzBZD+EEEZ6s+GQrEzK1SkXiARqK1lNfa1JSs2vJA82HUiIhZLDF
         +3+th2XTQTlHS+Gr9K/NjwH87VyQT353pwgLibVx04yjRMfd5W+b+G/emkZ1QH1QMCdp
         +VdUR0bh6PjKBYDAcrzubd7MQWNm6nDsH13UPGoZxwYcHNQDr//t9M88eoMItQaZsmRL
         EZvKlkNyMewVrjWqNakBNoRdDRhTOaemmNEiFctMlJI7UAlL79+JBnnmYpaICVplE1+V
         q8KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vOfKAt2EOhHolKwG7ZmDLU43lxbEY1uJX5ZWABu31QQ=;
        b=sZC9f6RkFLDK+4VAyfRatDxn8J4/XQsx26+pAgGqGM27K2aHttWXxtk7jHLsO/yaJv
         YPoYDl1TopS0FOScgP2s1u84q6O2Dd/p/JfyaiqhmFRy9SLdw9H/boSrvDG8wd+PLif7
         fHpsKp3bFMHqNP0B/ALZF02Bf0E73uPivRpiLWiNxZ0kiX6h54/clrb7Qj99UPtKrYxh
         q6KlVodP1yXD+s5FJNtbedMOsaEddBDAR+lT5VUpZ8CMyzWhsAv4SOSjBB3YqUkVoppY
         Wit6b70UUN+eCED5ky1QkEXLZBGdmYz8EiSreg/lLtkOWQ7NzW1s9lnf6I8337wpgJZd
         RL3g==
X-Gm-Message-State: AOAM530gmCDXvNnY2vjXOGgKsqvkKzLCbav2CvRSreUjWjBHg1yKFeX7
        IYhVEeiTgfmm2WarRWW/mt0Jzg==
X-Google-Smtp-Source: ABdhPJx91C9FQHNnNZvhcNOxh+KGKkfzF/EdY71onEWTAAXmVKrkJ79E8jSYaVV8L1jl5IAC7jZS5w==
X-Received: by 2002:a37:52c1:: with SMTP id g184mr6073859qkb.364.1611085473749;
        Tue, 19 Jan 2021 11:44:33 -0800 (PST)
Received: from ?IPv6:2620:10d:c0a8:11d1::1325? ([2620:10d:c091:480::1:a066])
        by smtp.gmail.com with ESMTPSA id f125sm13574381qkd.22.2021.01.19.11.44.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Jan 2021 11:44:33 -0800 (PST)
Subject: Re: [PATCH v3 2/4] btrfs: introduce new device-state read_preferred
To:     Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com
References: <cover.1610324448.git.anand.jain@oracle.com>
 <3f27d3da96accec05273a8ffc2a2d24554c78a1b.1610324448.git.anand.jain@oracle.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <faf2803a-aa3d-5bf3-03ed-e09554aedaaf@toxicpanda.com>
Date:   Tue, 19 Jan 2021 14:44:31 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <3f27d3da96accec05273a8ffc2a2d24554c78a1b.1610324448.git.anand.jain@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 1/11/21 4:41 AM, Anand Jain wrote:
> This is a preparatory patch and introduces a new device flag
> 'read_preferred', RW-able using sysfs interface.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
