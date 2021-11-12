Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FB2444E9DC
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Nov 2021 16:19:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbhKLPVw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 12 Nov 2021 10:21:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbhKLPVw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 12 Nov 2021 10:21:52 -0500
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D7A5C061766
        for <linux-btrfs@vger.kernel.org>; Fri, 12 Nov 2021 07:19:01 -0800 (PST)
Received: by mail-qk1-x736.google.com with SMTP id 193so9338934qkh.10
        for <linux-btrfs@vger.kernel.org>; Fri, 12 Nov 2021 07:19:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:references:in-reply-to:content-transfer-encoding;
        bh=MAIwcyYNGO0tQDQl5bPjR+jZ0+fiV9LbUfB6nDedo2w=;
        b=T71a79hBwFRDkz/Cx4dYL5Hh7f5HnfDlegEn8R9AXNPG4QiudP+8folbn7PUZ3jx9c
         CIYtKZt66T+xQHPMr+fn9EzgwQOtDQqNTofW3BvRXaZLnhfbZv3XUn9v1FjHjqX2UHBj
         vYIvfcudIuZYXNKPCv8QE8tbzkxw2SLJ74EOKUQI1dPusvTkJzXS0jMLvMiIRxzgMWau
         nW+AqYddCY9/sIgSnM9lYjvVhP3Mdv9Iw74h5gnbresPMdiMr2YMtIM8ysVpWoJrBkki
         yAn6HAYQhLUnW6pEKreWeuMUue7P1oIr/Gcy12nDovGf017M+CoibJYYn6BYocN/zmM2
         3QGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:references:in-reply-to
         :content-transfer-encoding;
        bh=MAIwcyYNGO0tQDQl5bPjR+jZ0+fiV9LbUfB6nDedo2w=;
        b=Z3YBtzZnobm0f4d5pH+LzNtkCxPK7IIL7KG5Sm2wxkwLMdhXaYUJUxaA7TVmxpira8
         z/z0n/0hRuSflufBqDzHhlrysiIiykZyLQ1Te0DhVbtezEmS6RXgXdkgzPmuduTP49Lh
         ZEl5kqWRqlUX+Fq3QtAIX3BBA9sDhwZUq7gPxwLjQVIEHNp1pefcs783nQnLQL1ylLny
         E7PMRSWE+MSKCiA5H37NqXjZY/byyCw48Yf+18u2Gc7V+l5wrU9B10FBsQraE/HZebX7
         fjiK2n4L/S8aVXdkTYAAhqeqwpySYh53R/SfwPdhaO6nSFXJ+tUB3r1pwiaX9N2kIo6a
         Gyrw==
X-Gm-Message-State: AOAM533DxrfhgZPXLhNRWGu9xLWjiiSA37TnXAhM6Zp6mUd1cgl92CA2
        T58yekfGDynDbA6zL5hcbNKDjUCEico=
X-Google-Smtp-Source: ABdhPJwJOcCrgWQzThgATL7dj9pNrPLd9OJr8Dn6OPPqZvAXa2dj4PoJHZABDcMQRoUqpqJU0fuRmA==
X-Received: by 2002:a37:9d8b:: with SMTP id g133mr12652481qke.180.1636730340181;
        Fri, 12 Nov 2021 07:19:00 -0800 (PST)
Received: from ?IPV6:2800:370:145:9a30:6737:e27b:1ad4:800? ([2800:370:145:9a30:6737:e27b:1ad4:800])
        by smtp.gmail.com with ESMTPSA id k23sm3003233qtm.49.2021.11.12.07.18.58
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Nov 2021 07:18:59 -0800 (PST)
Message-ID: <148e9643-7154-d5f6-ff95-34fc601bfa1f@gmail.com>
Date:   Fri, 12 Nov 2021 10:18:57 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:88.0) Gecko/20100101
 Firefox/88.0
Subject: Re: Upgraded from Buster to Bullseye, unmountable Btrfs filesystem
Content-Language: en-US
From:   "S." <sb56637@gmail.com>
To:     linux-btrfs@vger.kernel.org
References: <a979e8db-f86a-dd3a-6f0a-588b14bbd97f@gmail.com>
 <37379516-cc7c-b045-ad2e-15c669a60921@gmail.com>
 <179e61f7-82c9-0a5f-1a05-7c0019b4f126@gmail.com>
In-Reply-To: <179e61f7-82c9-0a5f-1a05-7c0019b4f126@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Here's an update and hopefully the conclusion to this thread:
Qu has been a huge help, and I really appreciate his time and patience. It was ultimately necessary for him to manually repair my tree block, since my NAS uses an old and obscure processor architecture. But in the end he sent me back a repaired tree block file with instructions to write it back out to my disks, and now the filesystem is working fine. Still no idea how this happened, as memtester doesn't find any issues. It's possible that I hit some weird 32-bit quirk, as I imagine that not a lot of people are running Btrfs RAID-1 on 32-bit systems. The good thing that came out of this is a new `clear-uuid-tree` function that Qu is proposing for btrfs-progs, so hopefully there will be an automated way to fix this weird error if it hits anybody in the future. Thanks again for the support!
