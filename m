Return-Path: <linux-btrfs+bounces-15557-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CC6EB0AA34
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Jul 2025 20:36:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA1CA5A26A2
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Jul 2025 18:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77B572E7F39;
	Fri, 18 Jul 2025 18:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="qw6MQ+yq"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 692DD2E7BC4
	for <linux-btrfs@vger.kernel.org>; Fri, 18 Jul 2025 18:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752863791; cv=none; b=DL6PW0M2HE5kPPXtcA9axVuQ44GpmhkXGt/iVFBGa5OtdYUoH7d+f9W96VTGVoPUOdMTjW5nAOnJr9B6KCnM/etQbSSRJgeka7Nw7CngYLKMZaxCWHF2fM/f+gVCGU8Fk99S7gbmMuwwktoZhNtMrpGvzd3g7p9RnPAQTN5KP54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752863791; c=relaxed/simple;
	bh=HmaDJ6KK/j+23WfgCx9P6RwpeK3ivPr/AAAIqHCjyXE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=CZgTgHfKQxwlb0TIxR+kUbpUs/Oy5lq04lYLFjsbjvxnmuAGgHNenx1ek449RGUOHFJDQGbDJ00x0sOnPqUbYcgEw3DLzpGD3fOV0CWy+/9mZ1PmppnR0WrT/VjVDvnqlJiPiguU6OlHVM1kebkB62synB+MaXpfEb9iC0yWR4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=qw6MQ+yq; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b31d489a76dso1999351a12.1
        for <linux-btrfs@vger.kernel.org>; Fri, 18 Jul 2025 11:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1752863790; x=1753468590; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ypu6ZHCyCszmGrmZOwZT0mlh993mGs8sK1TJDH55uDw=;
        b=qw6MQ+yqr6YxfiGojuoH29i7u/r/IjCUaJNQ+lekfuOy+6dH8EdG8hdOgfe3s6NyJ7
         gCP9UF43bjRL74cYb4eRUEBuWdPBLwTQzE1j0yd24BI1pmugxjlN68KUQCWO5VVAm1Ir
         jtnqHwsi2lwMznm1G+5mKQdaYDdcN5vsRwqIDjmjPGE+TgQY5iZrK2bs5d6PzNPEg8dr
         6NJJApLyTaWMhGL1JAlDKUU2Uz8X9gO70ki7O9SLaNOck75R+I7BoYLH33/txV6jsj/F
         R61UFXxizZrBH/F37DHl7nHAb39uRP7WSxYqM161f36k48MtajFykwviJOGe7Jw/3j2+
         lgUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752863790; x=1753468590;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ypu6ZHCyCszmGrmZOwZT0mlh993mGs8sK1TJDH55uDw=;
        b=fKU1xRVY8PHWvN8aW3b6VgwWPNxdoEmUfBb7D9hjpxkRe8ixb0mY13gLezXYUPFYHr
         fhnuHOlUVIQc50aRacjs6iI/txNA+K1AJ3yZK3IGbqVxk0XcE5iEDEdBOEHrj7f3KBeS
         sulpmDw4NHL0dXWPrzCByhK0noPTR1bqZv2ivRRW7TAutAc2P9prcGMAjXOXdvoz5h16
         spX6C9NCP3lApMEAOvNBQzP8kZCooVOzNigdroKj5smEJOznuiSy/WexpJMRDST91J5u
         v3Rd58lG/hWoWAcVyQHGvTfQh1osddzu2ywzF27H8XRtbKct+nhxHZUVnb4/1GZkmEgO
         zhfw==
X-Forwarded-Encrypted: i=1; AJvYcCXGyCgYNbNadNMeAK577952sgZiR2cSqhhLclDdDrSQCyKzqhZx1N2drnVhEnMHxcXR9+U3QFfwfu4Tww==@vger.kernel.org
X-Gm-Message-State: AOJu0YxaMD4J3As6JauUjExjENrKcyDpKeGqGQHxpHrdKLvM/GllTzSi
	5Pk4YCJ0naLTShjsx67xBsdoQTuter214TzjFyJnu9AzqEm7Synrulx7HLkbrkliHlU=
X-Gm-Gg: ASbGnctssXAhXb0R6bp6mmLfHoHTpOWs256wr15SKy+ZeHL6mnoWUe15Erx+bxOB+5f
	dK3qv259pcQD2Kb/K5ka+mtaoTO4V/CJ8LxrO/OL6/f3U2x1n63r6ZL5zQsg0X/iq/JlGRHh57J
	exiIzNVruPV4PIzef0smI7NNo9cEuQqn8bmWrhESmhTbTNeGEfPM4Aj/dnm+nlEIBHVjIIFwVEu
	WYvEhU+RjtLjfOZjq6g9GEkpJMQoCDFJJp5GZt/QVkpu8wB1ykOclxBg/I6UtFxG9GGnB9Z87hl
	0k3rgcyAC5721GmGuVOWOEptCkKO0k3nLGULUC68dXgrHw7NFDbSmY9f0U67n1k4qVJL0MP9jQc
	pq30BF+BtgHAzF+SailVCUCn0/QnbgwKtzBq3LxgS/fyccn0JYygnRQ8=
X-Google-Smtp-Source: AGHT+IGlsDntYJxObfrXYgVH/QPpuidAJOMArNU0943U5rKRF8s3x8qPhf9Yje8PPd+9AhltaJnSPQ==
X-Received: by 2002:a17:90b:254d:b0:313:352f:6620 with SMTP id 98e67ed59e1d1-31c9f435558mr16657207a91.4.1752863789743;
        Fri, 18 Jul 2025 11:36:29 -0700 (PDT)
Received: from [127.0.0.1] (syn-071-095-160-189.biz.spectrum.com. [71.95.160.189])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c9f1e6a68sm5636796a91.19.2025.07.18.11.36.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jul 2025 11:36:28 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
 David Sterba <dsterba@suse.com>, 
 Caleb Sander Mateos <csander@purestorage.com>
Cc: Mark Harmstone <maharmstone@fb.com>, linux-btrfs@vger.kernel.org, 
 io-uring@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250708202212.2851548-1-csander@purestorage.com>
References: <20250708202212.2851548-1-csander@purestorage.com>
Subject: Re: (subset) [PATCH v2 0/4] io_uring/btrfs: remove struct
 io_uring_cmd_data
Message-Id: <175286378826.415706.5386510015448817454.b4-ty@kernel.dk>
Date: Fri, 18 Jul 2025 12:36:28 -0600
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-2ce6c


On Tue, 08 Jul 2025 14:22:08 -0600, Caleb Sander Mateos wrote:
> btrfs's ->uring_cmd() implementations are the only ones using io_uring_cmd_data
> to store data that lasts for the lifetime of the uring_cmd. But all uring_cmds
> have to pay the memory and CPU cost of initializing this field and freeing the
> pointer if necessary when the uring_cmd ends. There is already a pdu field in
> struct io_uring_cmd that ->uring_cmd() implementations can use for storage. The
> only benefit of op_data seems to be that io_uring initializes it, so
> ->uring_cmd() can read it to tell if there was a previous call to ->uring_cmd().
> 
> [...]

Applied, thanks!

[2/4] io_uring/cmd: introduce IORING_URING_CMD_REISSUE flag
      commit: 733c43f1df34f9185b945e6f12ac00c8556c6dfe
[3/4] btrfs/ioctl: store btrfs_uring_encoded_data in io_btrfs_cmd
      commit: 9aad72b4e3f0233e747bb6b1ec05ea71365f4246
[4/4] io_uring/cmd: remove struct io_uring_cmd_data
      commit: 2e6dbb25ea15844c8b617260d635731c37c85ac9

Best regards,
-- 
Jens Axboe




