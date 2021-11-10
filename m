Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B062144C2AA
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Nov 2021 15:01:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231822AbhKJOE1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 10 Nov 2021 09:04:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231607AbhKJOE0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 10 Nov 2021 09:04:26 -0500
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12F01C061764
        for <linux-btrfs@vger.kernel.org>; Wed, 10 Nov 2021 06:01:39 -0800 (PST)
Received: by mail-qk1-x736.google.com with SMTP id de30so2585137qkb.0
        for <linux-btrfs@vger.kernel.org>; Wed, 10 Nov 2021 06:01:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=bMbxFLdkuEpP+iERi0uHWOFEBDbEkQlR/uvz/lu2t2Q=;
        b=eD/9qoprbmqWEVYeQfSdE3npZrYujcF4H7M0fZsIdVQkeLVhLIgmw+VAJwbJHLSFg1
         R8CYd3L687gXwGU+ObWdR5eiStD0FVvm0Rn0zVWgKjnk0f7AtufLsOQYn4jPYYhaqc4v
         2dL9u0e5CQCQSd+cr5Fwdioa+k9vok8597JHhw0M4oQ5WeSGEehUMAEOKY/+677vrX3t
         ztkZ/AwIgQD2QSTnsNtJuSdkV+Rxt2XGoEdKMZv35K8zKHzN78REMvz3eEy6XqvECVsD
         XqSvWOcDYySylTbUf13jboJ2zVe6F2JGS3Bv1PXl6HtBYdXoI1M9x0M/GbtlpECZytXi
         KxLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=bMbxFLdkuEpP+iERi0uHWOFEBDbEkQlR/uvz/lu2t2Q=;
        b=WHvBu42b5IaYLshk3tGGP71WIpM3NJnJmetNiNKZSb3kLKiIfsD7dvyuqdXLCP0Xkl
         P8Rdqfhi3QHjVsJNaNW3v5HsP8zByw0UWwr/2NK1zVi9CcSCgJOQpZBovf5JXUbUshAr
         gPBPcvOK9pJTL++K50OAf/C+87rdUPR62IQUlnoubgA9p+w9s902uYQJKx68MGvUr55u
         bAwUJcyWhWXeq4W8v6g+C/iZcN96FCntHm0hh8tRsKWJ5bEwafjIJyyG84Q3IW+Yzta9
         JO3pfBoBETjgSA53ucojP3fO5NN2t2dNACQokqIeAAq6DtzWbU77a70Ku+Aunvp5UL8I
         7AjA==
X-Gm-Message-State: AOAM533A7Ly677Cvf1CRBa20UB2Ajsal2Q1NC9LapMh1j3jB7lZCi7+e
        jsEZt3a8WmDe+o5cirxuzkS7UZBfZ4o=
X-Google-Smtp-Source: ABdhPJxW7ojTnU1r767xqFREe4+mirkc3ziNYpP1yeg4FvHCGSPpxL7tLgPdzPSf3aYHmp8IA69MRA==
X-Received: by 2002:a05:620a:410a:: with SMTP id j10mr12874269qko.472.1636552898262;
        Wed, 10 Nov 2021 06:01:38 -0800 (PST)
Received: from ?IPV6:2800:370:144:81b0:f245:e007:48ea:38b5? ([2800:370:144:81b0:f245:e007:48ea:38b5])
        by smtp.gmail.com with ESMTPSA id 139sm5131802qkn.37.2021.11.10.06.01.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Nov 2021 06:01:37 -0800 (PST)
Message-ID: <c94ecfa2-752b-9952-9483-ae3dd04f6c02@gmail.com>
Date:   Wed, 10 Nov 2021 09:01:34 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:88.0) Gecko/20100101
 Firefox/88.0
Subject: Re: Upgraded from Buster to Bullseye, unmountable Btrfs filesystem
Content-Language: en-US
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
References: <a979e8db-f86a-dd3a-6f0a-588b14bbd97f@gmail.com>
 <37379516-cc7c-b045-ad2e-15c669a60921@gmail.com>
 <179e61f7-82c9-0a5f-1a05-7c0019b4f126@gmail.com>
 <76156d73-9d4c-a473-4dd2-105a905d3d1e@gmx.com>
From:   "S." <sb56637@gmail.com>
In-Reply-To: <76156d73-9d4c-a473-4dd2-105a905d3d1e@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


On 11/10/21 02:01, Qu Wenruo wrote:
> If you can revert to older kernel/distro, then you can mount the fs with
> "-o rescan_uuid" to regenerate the UUID tree using the old kernel.
> 
> Then it would rebuild the UUID tree, no need for a tool in user space.

Thanks very much for the explanation and for the suggestions.
Fortunately the system saved a copy of the old 4.19 kernel and initrd image. You are correct that the old kernel can still boot the filesystem without errors. Then I unmounted it and remounted it with `-o rescan_uuid_tree`. This also appeared to work, as it was able to mount. However, after rebooting into the new Bullseye kernel the filesystem is still unmountable:

------------------------
[  115.250774] BTRFS info (device sda3): flagging fs with big metadata feature
[  115.257773] BTRFS info (device sda3): disk space caching is enabled
[  115.264089] BTRFS info (device sda3): has skinny extents
[  115.414229] BTRFS critical (device sda3): corrupt leaf: root=9 block=170459136 slot=0, invalid key objectid, have 1101835439474057344 expect to be aligned to 4096
[  115.428780] BTRFS error (device sda3): block=170459136 read time tree block corruption detected
[  115.459643] BTRFS critical (device sda3): corrupt leaf: root=9 block=170459136 slot=0, invalid key objectid, have 1101835439474057344 expect to be aligned to 4096
[  115.474296] BTRFS error (device sda3): block=170459136 read time tree block corruption detected
[  115.483109] BTRFS warning (device sda3): failed to read root (objectid=9): -5
[  115.534748] BTRFS error (device sda3): open_ctree failed
------------------------

Any more ideas? Thanks again.
