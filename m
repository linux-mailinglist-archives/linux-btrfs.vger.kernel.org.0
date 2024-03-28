Return-Path: <linux-btrfs+bounces-3695-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E4AE88F622
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Mar 2024 05:03:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DB7B1F2A70E
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Mar 2024 04:03:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC6443BBD7;
	Thu, 28 Mar 2024 04:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HD3hZs+N"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BB1D39FEC
	for <linux-btrfs@vger.kernel.org>; Thu, 28 Mar 2024 04:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711598600; cv=none; b=Bc+YvZLhzMVkrlAjuXnBm+R1S2tn6yP/LJ81gifbxT76o1foAWNoFj7F1DEoPwIFte6Cy/866E9by73zEhYJUiq/lKHJkP3pkXnCFtZ6Z3AkJFNsdyCFE6pzX4CZaIsLnnoBjv7VUnFw5x/U6BKO115ORrCSaKCuAtZZJigyW6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711598600; c=relaxed/simple;
	bh=wJEpomubSOpCg4laFMnGiapTSGnjApwKTdgsQTsaOKQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fOt4/DUxGLW5nLNJeu5PbonDPG+UpAu3zylSg8NCL6gO1IKflTMJgCXqEXGyFoSw7B+13u175FrPlfYRwAzNEjDei/fY5gA6qb1A1AFi7Hg4ZIAwuXD2h1Q+tb85ZbQkcuuF3ktuxB0tkeM8JshlceEACE+m7FyGJai5dqoC/QU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HD3hZs+N; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2d49871732fso911021fa.1
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Mar 2024 21:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711598596; x=1712203396; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BULq/i7a8Y9b7UGT2N/8TjsEH1M/khQrds2FSTFev5E=;
        b=HD3hZs+NuBLQGZJue45NdKcS2ftJz0nWydaTytBv4OwX4ZGY3CYP4QxpHq0oHe6vcA
         LExI9hRLUo3AHnP9juWD4yPQ1kvvT1tZ/159kJUaE3AWR/cMMg8DBIFBqlXi6kf4ZrpG
         rdOeXS5Qn2JYTUA0q2ZuhiKXOA9ah3dRjx1NgYEknOeFVt6kIdRFF1C75zouUjrR5T9H
         85uVfNBzMXuZygH6GcklVMlE1o7WDt/dK5fP0stEtf311Bsn6BqMx2eGTSztMjED5EYw
         yB2bODKZX8BJ68yeQYQtODdjJ43YfYbpbUOs7feAX4Bvz3xrPn4HKF6HLuYXuAQVuzKQ
         SrbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711598596; x=1712203396;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BULq/i7a8Y9b7UGT2N/8TjsEH1M/khQrds2FSTFev5E=;
        b=wXBa/z1Z/wUsncmuZR8cLw9Z2TxWsQVqlsqe+EmV1FHMiovjMGNp1gESfA8cfMB7t3
         qE0VweqVJ6OQoP+JqfHLkdVcxlAvuFV68JV6nNbAjQIPu1ytRPG3KAonQDkvyoOosUn7
         nNq6wGfktVBSh4UTcRWdXvfmrAkJ3VkkXThl7ygQsnkHmg9Afj2Ez1rmH8y3VNBDks34
         BGmWflMUCnqn7dqT64lGlD+BBYmvnYB+65PJ60q+FQvqQdUSWEacT7DFJL/tfmaPn5fR
         BHZ9AhCbhmEiDy3uT7xpHBkAViCUtrd0is8BVdz7NqC7hZwFJWroxu6Lb9n3hygPdXNG
         96qg==
X-Gm-Message-State: AOJu0YxOKhMmqCZzfNrI2ZsIxNX0TglzVzzxazuJ26Yuk4kfx53G9/fo
	VQCfh5UTr2aGI7VhHkcQoGGaJmWS/ShLUb0fkTZ5xi3GMXxVIYCe
X-Google-Smtp-Source: AGHT+IHyTZvITlhcTkoaJMe5uHUa7Gl1AFz0ym6xzcFKRHovtR41T1kES2U1EPbNY4/0sHLZAQwQ8w==
X-Received: by 2002:a2e:b043:0:b0:2d4:7458:b65 with SMTP id d3-20020a2eb043000000b002d474580b65mr1298437ljl.2.1711598596220;
        Wed, 27 Mar 2024 21:03:16 -0700 (PDT)
Received: from ?IPV6:2a00:1370:8180:8557:e7f3:8ef9:3229:a262? ([2a00:1370:8180:8557:e7f3:8ef9:3229:a262])
        by smtp.gmail.com with ESMTPSA id g7-20020a2ea4a7000000b002d557895e4dsm81319ljm.131.2024.03.27.21.03.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Mar 2024 21:03:15 -0700 (PDT)
Message-ID: <a078d357-fcdb-4f92-b4ee-a91e5ad8b398@gmail.com>
Date: Thu, 28 Mar 2024 07:03:14 +0300
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: raid1 root device with efi
To: Matt Zagrabelny <mzagrabe@d.umn.edu>, Forza <forza@tnonline.net>
Cc: Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
 Matthew Warren <matthewwarren101010@gmail.com>
References: <CAOLfK3UccL8z7Xf_KSp=foS6hM8Byf5n_21uwO96=9ND=-j84A@mail.gmail.com>
 <CA+H1V9x-pFAM-YQ1ncAqZE4e7j6R2xQXX6Ah9v1tMNf8CrW+yw@mail.gmail.com>
 <CAOLfK3We92ZBrvyvSDky9jrQwJNONeOE9qoaewbFCr02H8PuTw@mail.gmail.com>
 <CA+H1V9xjufQpsZHeMNmKNrV0BfuUsJ5G=x_-BEcRw7eNFhYPAw@mail.gmail.com>
 <CAOLfK3UEOMN-O9-u6j22CJ0jpRZUwB7R_x-zEH6-FXdgmqB7Lg@mail.gmail.com>
 <1eac6d15-4ead-46bc-9b60-02f1d120c885@tnonline.net>
 <CAOLfK3UuMNn1Q2t-seqcOXu4xVbWQU4rOSVkY2qn4RsyOcBCAA@mail.gmail.com>
Content-Language: en-US, ru-RU
From: Andrei Borzenkov <arvidjaar@gmail.com>
In-Reply-To: <CAOLfK3UuMNn1Q2t-seqcOXu4xVbWQU4rOSVkY2qn4RsyOcBCAA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 27.03.2024 23:21, Matt Zagrabelny wrote:
> 
> Are folks using the "degraded" option in /etc/fstab or the grub mount
> options for the btrfs mount?
> 
> I've read online [0] that the degraded option can cause issues due to
> timeouts being exceeded.
> 

That is incorrect. The "degraded" option does not "cause" issue due to 
timeouts which happen long before this option is even seen. It does not 
fix them, that's true.

> Also, I'm seeing some confusing results of looking at the UUID of my disks:
> 
> root@achilles:~# blkid | grep /dev/sd
> /dev/sdb2: UUID="9a46a8ad-de37-48c0-ad96-2c54df42dd5a"
> UUID_SUB="7737fc5f-036d-4126-9d7c-f1726d550444" BLOCK_SIZE="4096"
> TYPE="btrfs" PARTUUID="3a22621c-a4e1-8641-aa0f-990a824fabf4"
> /dev/sdb1: UUID="BD42-AEB1" BLOCK_SIZE="512" TYPE="vfat"
> PARTUUID="43e432b1-6c68-4b5c-9c30-793fcc10a700"
> /dev/sda2: UUID="9a46a8ad-de37-48c0-ad96-2c54df42dd5a"
> UUID_SUB="9436f570-6d15-4c74-aff8-5bd85995d92d" BLOCK_SIZE="4096"
> TYPE="btrfs" PARTUUID="e3b4b268-99e8-4043-a879-acfc8318232b"
> /dev/sda1: UUID="BD42-AEB1" BLOCK_SIZE="512" TYPE="vfat"
> PARTUUID="02568ee9-db21-4d03-a898-3d1a106ecbec"
> 
> ...why does /dev/sdb2 show up in the following /dev/disk/by-uuid, but
> not /dev/sda2:
> 
> root@achilles:~# ls -alh /dev/disk/by-uuid/
> total 0
> drwxr-xr-x 2 root root  80 Mar 25 21:16 .
> drwxr-xr-x 7 root root 140 Mar 25 21:16 ..
> lrwxrwxrwx 1 root root  10 Mar 25 21:16
> 9a46a8ad-de37-48c0-ad96-2c54df42dd5a -> ../../sdb2
> lrwxrwxrwx 1 root root  10 Mar 25 21:16 BD42-AEB1 -> ../../sda1
> 

How do you expect the one symlink to point to multiple destinations?



