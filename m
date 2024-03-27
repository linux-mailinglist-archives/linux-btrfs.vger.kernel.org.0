Return-Path: <linux-btrfs+bounces-3653-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3BE888E98E
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Mar 2024 16:43:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 998F729AC45
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Mar 2024 15:43:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 217B7130E2C;
	Wed, 27 Mar 2024 15:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d+CG1i0L"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 733FF130A43
	for <linux-btrfs@vger.kernel.org>; Wed, 27 Mar 2024 15:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711554021; cv=none; b=qMoVMa9psUrmpm7dlK7rf3MIk3uZabR1h97toOTuh4aDCCar6GVOFoKA85DfyYDa8Qb37esGlDLDZaGgyKsaGF06ohueY83dljQsFL8mxVeXUYqB5HltzDPAZ+ZoCiJaml3xOmSWRx87IbxTCAxgtXSK4juGMmz2BH0qYf0clsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711554021; c=relaxed/simple;
	bh=WOTI1LKhVW2P6Fal6RTWnzFskemFyqt47vH/iXC2ips=;
	h=To:From:Subject:Message-ID:Date:MIME-Version:Content-Type; b=BUbL5AstwvHZYZy58bRZslhAYA+bbQD7J9R4Eywv2nKpS2HFrXcrtU3mg1RAwvOmSEvS6AwZcdPyX/d1G5pZVaFWgIm6cYbh5W9Yls6QdBSd4F6aR71kmOB2PVFYrp0Uq+8K0cIZKozQcrdfYqxYt1vO9DK4YdtPUvBkX3z9DTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d+CG1i0L; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-341730bfc46so4946962f8f.3
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Mar 2024 08:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711554018; x=1712158818; darn=vger.kernel.org;
        h=content-language:content-transfer-encoding:mime-version:user-agent
         :date:message-id:subject:from:to:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iz4TrMSxeQZ5vsgBoiH7pnJs6evcVU/truBe9/F74kA=;
        b=d+CG1i0LlIQdhwvU+EMiSjQrM0bOMBXlc3iCqxymwRR92HxaQGhkwSJEhMh9RAhe3Q
         fWOFjaNBMJpc4tThtS20+ZZ4ghpdNbewOoRjTKo9YuXGD78KvahXb3a150wWFzziuEXv
         iN4nnkgiyogAGUjz+gpOMqp9cfcS8ShiZWxTyLVLVtfDtBC22THnpe8ojmpzuTrCsGW6
         tmthyAHft+TCuS4jtAEr96TrweMigDZ2uaCK5ABOEZHdnHfR5vr47xZzPSL7Q1x/nE9Y
         pT3/9t0T8bLn1J5/PfC4uHb+3G/J5v8XXsUn4kfi73/lpJn63yFnpOoDiRTsBcNicQ+z
         64cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711554018; x=1712158818;
        h=content-language:content-transfer-encoding:mime-version:user-agent
         :date:message-id:subject:from:to:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iz4TrMSxeQZ5vsgBoiH7pnJs6evcVU/truBe9/F74kA=;
        b=Jhc3Lg+510m+1P1tsNC89coS2nEIlqF9sls/EsNhwNdbLs3mWhsP2hNiR3DvlP4nEB
         OdW/CMGRxnBbSh3DEUp6FaW0sO2WEOd6XKffmvsdOHylHiKf8l81XGTDFFnNybShpBon
         SCDplOoiR540D4cR6th1VCFS4H4nPcM0O/x1xfxpAJhP+OmCfh/rQZbJ27AOopYI8s2K
         gNwBeF39QwRRyz7bzI9dMpPr9evHl3xAEZcoMnAoFAe2y0XI4UQlyNP8Vv1GkXNt8xai
         +emkRw/rYxesdAhC8CmSxVEhRntxQvhEsIdtEUDjvKMdq5z4C9w8s9xcyNF9NzpNTrp8
         3gNA==
X-Gm-Message-State: AOJu0Ywaj4H5G+t2mcvv3TPfEdMIF1CEKT9KI9CEwc9RsT8Bg7gcoSLd
	1pdTpgW7tFWup9HIXsMEDk6KU1jKaxRMjFSKwUXtld/AOu30LuC1JBojzwek/3Q=
X-Google-Smtp-Source: AGHT+IGafQ4mhol3XiSzHPErqQ9/PVGBzItQzRd+CjzLJTyNxAA8yeLFJcYKXazkNT8Pf2FRG264jg==
X-Received: by 2002:a05:6000:192:b0:33d:9231:d1c2 with SMTP id p18-20020a056000019200b0033d9231d1c2mr166385wrx.25.1711554017663;
        Wed, 27 Mar 2024 08:40:17 -0700 (PDT)
Received: from saxicola.serprest.pt (als-84-91-88-187.netvisao.pt. [84.91.88.187])
        by smtp.googlemail.com with ESMTPSA id ce6-20020a5d5e06000000b00341de3abb0esm2528116wrb.20.2024.03.27.08.40.17
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Mar 2024 08:40:17 -0700 (PDT)
To: linux-btrfs@vger.kernel.org
From: Isidro Vila Verde <jvverde@gmail.com>
Subject: BTRFS critical (device sdb): corrupt leaf: root=2
 block=62483789217792 slot=119, bad key order
Message-ID: <10e9b8c2-c215-c3c7-0570-611501c63957@gmail.com>
Date: Wed, 27 Mar 2024 15:40:16 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: pt-PT

Hello,

I have a problem very similar the one describe by Jesper Utoft () on

https://www.spinics.net/lists/linux-btrfs/msg86768.html

I read it carefully, and the proposed solution was to run:

/./btrfs-corrupt-block -X <device> /

However, I am confused, as its name suggests (and after looking at the 
code), it corrupts some blocks/nodes/extends. Additionally, it seems 
that Jesper Utoft ended up with more errors.

And so far, from what I've read in other places, it seems to be oriented 
towards testing BTRFS in situations where some blocks are corrupted.

I have a very large filesystem with 44TB (30TB used) and more than 2000 
snapshots. I can mount it as read-writable, but after some time, it 
switches to read-only mode

Mar 27 13:58:02 bkitusb kernel: [52589.935914] BTRFS critical (device sdb): corrupt leaf: root=2 block=62483789217792 slot=119, bad key order, prev (62482664210432 169 0) current (62480516743168 169 0)
Mar 27 13:58:02 bkitusb kernel: [52589.938672] BTRFS error (device sdb): block=62483789217792 read time tree block corruption detected
Mar 27 13:58:02 bkitusb kernel: [52589.947997] BTRFS critical (device sdb): corrupt leaf: root=2 block=62483789217792 slot=119, bad key order, prev (62482664210432 169 0) current (62480516743168 169 0)
Mar 27 13:58:02 bkitusb kernel: [52589.951451] BTRFS error (device sdb): block=62483789217792 read time tree block corruption detected
Mar 27 13:58:02 bkitusb kernel: [52589.953243] BTRFS: error (device sdb) in __btrfs_free_extent:3066: errno=-5 IO failure
Mar 27 13:58:02 bkitusb kernel: [52589.954228] BTRFS info (device sdb): forced readonly
Mar 27 13:58:02 bkitusb kernel: [52589.954231] BTRFS error (device sdb): failed to run delayed ref for logical 62480515022848 num_bytes 16384 type 176 action 2 ref_mod 1: -5
Mar 27 13:58:02 bkitusb kernel: [52589.956174] BTRFS: error (device sdb) in btrfs_run_delayed_refs:2157: errno=-5 IO failure
Mar 27 13:58:02 bkitusb kernel: [52589.959639] BTRFS warning (device sdb): Skipping commit of aborted transaction.
Mar 27 13:58:02 bkitusb kernel: [52589.959648] BTRFS: error (device sdb) in cleanup_transaction:2018: errno=-5 IO failure//
/Trying to use |btrfs check|(without the --repair option), I got: /Opening filesystem to check...
Checking filesystem on /dev/sdb
UUID: 42d6c432-cf84-4185-a247-2a8933182caa
corrupt leaf: root=2 block=62483789217792 physical=119589732352 slot=119,  , prev (62482664210432 169 0) current (62480516743168 169 0)
corrupt leaf: root=2 block=62483789217792 physical=5344484556800 slot=119, bad key order, prev (62482664210432 169 0) current (62480516743168 169 0)
corrupt leaf: root=2 block=62483789217792 physical=119589732352 slot=119, bad key order, prev (62482664210432 169 0) current (62480516743168 169 0)
corrupt leaf: root=2 block=62483789217792 physical=119589732352 slot=119, bad key order, prev (62482664210432 169 0) current (62480516743168 169 0)
[1/7] checking root items                      (7:11:32 elapsed, 617763628 items checked)
ERROR: failed to repair root items: Input/output error
Killedchecking extents                         (1:12:26 elapsed, 2559729 items checked)

I don't mind losing some files or entire snapshots, but since it's a 
backup disk, I would like to maintain as many snapshots/files as possible.

I already move the discs to a new server with 128GB of ECC memory and 
boot it from a usbpen with Ubuntu 22.04.3 LTS and btrfs-progs v5.16.2.

Trying to use

sudo btrfs inspect-internal dump-tree -b 62483789217792  /dev/sdb

I got

btrfs-progs v5.16.2
corrupt leaf: root=2 block=62483789217792 physical=119589732352 slot=119, bad key order, prev (62482664210432 169 0) current (62480516743168 169 0)
corrupt leaf: root=2 block=62483789217792 physical=5344484556800 slot=119, bad key order, prev (62482664210432 169 0) current (62480516743168 169 0)
ERROR: failed to read tree block 62483789217792

Is there any possibility of getting rid of these issues, or is the 
filesystem definitively ruined?

Thank you for your time!

Best Regards
Isidro




