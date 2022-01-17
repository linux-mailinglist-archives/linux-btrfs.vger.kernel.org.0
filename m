Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCB4D4901C5
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Jan 2022 06:58:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234441AbiAQF4Y (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 17 Jan 2022 00:56:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234293AbiAQF4X (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 17 Jan 2022 00:56:23 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 439E9C061574
        for <linux-btrfs@vger.kernel.org>; Sun, 16 Jan 2022 21:56:23 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id e3so50691580lfc.9
        for <linux-btrfs@vger.kernel.org>; Sun, 16 Jan 2022 21:56:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+4xwUmACYCLwM/R1CbL7XDDAC1gBxrmtrwbGvcObgoo=;
        b=qPipXk25FEcV3bLvYXgyVdGvuvVvX8FVsPEwQ3QzjEMCH8SZ1yhBfv/FnEEGyzP8n+
         Zd1Xztlp4XHuoIRs3zbxbWO0qNb8akW5mppV3z6wV9O0+cwokgAqmwoKqBN/89NlJ7ta
         +24bFT626KHoE8kwEDbNk1eCT08xxxD9CWNx/tWWtYUkzCicWRWjf2K8JlYZr0nws0P4
         qTmDzVmYuHqIQT+LL7+xJsBIlxXc3QPa5tZsDXlHZ7F4+e63pmgX7DUt/x3vYrRQ9bnH
         b+NnJA4juCMC2yLmIMYbvWBBjvMR2LunBchXn7HPrjH7ydm8PGOd65jNwCQyfW6K86Rg
         krkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+4xwUmACYCLwM/R1CbL7XDDAC1gBxrmtrwbGvcObgoo=;
        b=LRESaIP1cQ4DWjs3sat5u97Lvg+wEHnr0vq1RoFfJicRhDnm1P8fjy9YfAkMk4znP0
         lr+oYB6nmsYfQhge/yETad2zWfYac+YtO+L+JIOE32yoIa3namdKOVa6SuowRGJIuYzz
         rxa7lp8PKGvunQroQfz/yVroTPr+fCHY40DAl118liSEQ7p76W8axdQiOeYiLVja3Ijd
         rORisbzD9JzedArpnGrzSw3XhBTsK/LsOcbLzeiS60CHQaDjdIa62EliZzpJgvuUIvuc
         FNJfAWCxTft3vSATzkCkigAwvkWuER0mxzOuNbbxi9Pzef0xRwwB3YLxCIDVsJe1m7Ca
         Saow==
X-Gm-Message-State: AOAM532n1BRX4Q96QJ+iv7ybouq8Dma2nQg3lXrWMvvhUr5BbPHZvnKp
        /dNT9D9EiG8FpDtR6ad7GAZaeN8wEa8=
X-Google-Smtp-Source: ABdhPJx62W5Nv2xU1QHhCacdfnX8ett5rvmpre7A7iFG5G0vTSqjMk1dXTdFmEn8lctIa5CHaMGJeg==
X-Received: by 2002:a05:6512:12c9:: with SMTP id p9mr7188778lfg.97.1642398981665;
        Sun, 16 Jan 2022 21:56:21 -0800 (PST)
Received: from ?IPv6:2a00:1370:812d:2c5:9107:c503:6c4c:b8b5? ([2a00:1370:812d:2c5:9107:c503:6c4c:b8b5])
        by smtp.gmail.com with ESMTPSA id z9sm1133276ljm.77.2022.01.16.21.56.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Jan 2022 21:56:21 -0800 (PST)
Subject: Re: 'btrfs check' doesn't find errors in corrupted old btrfs (corrupt
 leaf, invalid tree level)
To:     Graham Cobb <g.btrfs@cobb.uk.net>,
        Stickstoff <stickstoff@posteo.de>, lists@colorremedies.com,
        linux-btrfs@vger.kernel.org
Cc:     quwenruo.btrfs@gmx.com
References: <6ed4cd5a-7430-f326-4056-25ae7eb44416@posteo.de>
 <CAJCQCtSO6HqkpzHWWovgaGY0C0QYoxzyL-HSsRxX-qYU2ZXPVA@mail.gmail.com>
 <13d3ebcb-f261-35eb-0675-3cb199ad3643@posteo.de>
 <f8de013a-9b1b-f471-4af0-dbb587264774@cobb.uk.net>
From:   Andrei Borzenkov <arvidjaar@gmail.com>
Message-ID: <8fc2fd54-0fec-a4f5-30f5-fdd68cd4e181@gmail.com>
Date:   Mon, 17 Jan 2022 08:56:20 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <f8de013a-9b1b-f471-4af0-dbb587264774@cobb.uk.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 16.01.2022 13:25, Graham Cobb wrote:
> 
> On 16/01/2022 09:31, Stickstoff wrote:
...
> 
>> Scrub did abort, and force the fs read-only, but didn't unmount it.
>> Also, my backupscheme depends on btrfs-send and the IDs of snapshots.
>> Migrating from the
>> old corrupted fs to a fresh one with btrfs-send should keep all the IDs
>> as they were,
>> so my backupscheme would not see any difference when picking up with the
>> new fs?
> 
> I don't think send/receive preserves subvolume IDs. I think it only
> preserves "Received UUID". But I may be wrong.
> 

You are correct. btrfs receive creates new subvolume which gets next subvolume
ID on target filesystem and own unique subvolume UUID. Neither of them have any
relation to subvolume ID and UUID on source.

Received UUID is set to source subvolume UUID unless source subvolume has 
received UUID itself.
