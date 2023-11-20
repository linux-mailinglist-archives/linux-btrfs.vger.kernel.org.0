Return-Path: <linux-btrfs+bounces-210-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 166F97F1E8B
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Nov 2023 22:11:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C00D91F2303D
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Nov 2023 21:11:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03F5136B19;
	Mon, 20 Nov 2023 21:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="abZo0xON"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E9E9CF
	for <linux-btrfs@vger.kernel.org>; Mon, 20 Nov 2023 13:11:47 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-4079ed65582so18224335e9.1
        for <linux-btrfs@vger.kernel.org>; Mon, 20 Nov 2023 13:11:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700514705; x=1701119505; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pilji3VfdnaXa7Xtgj8molN3fG4jkmBjYOn49QI89ZY=;
        b=abZo0xONSmSPKfEsBs5MyIngeVaBE/F5E7QCNcU4mmfyvh2WrFrfoIbz22sI7WDSQv
         ILdyqeqpMvi8H6sgAlk0caRqvsdnkBCehVpgmHS3uj7GdbIGe71zOyKTOconJBLJhWwR
         pUOjGS02uKjRkC/CgRjDnSB/CqA1oJws/ARBBFRh2FDoYfePVPqDZOyqiUFx8YxQqOM5
         GNWhf73UGh+2FWNIY8YYISI3uBCvpW1q9Ejgn3rouHXxMQ59SkiYWR05ghT3zJRBS9pX
         /5WAJRMilRAEoGdzGZBtsQr7Vd9L733KBgn34UtAPTt2FEmqivR8DIuzvriJ9N5//rnF
         V0Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700514705; x=1701119505;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pilji3VfdnaXa7Xtgj8molN3fG4jkmBjYOn49QI89ZY=;
        b=TnE6bPcv7x4oAH9N5vGJmmzaUTdeZtqnczgVrdVhPN4aoTcwhIs2wVHGCPvaZOSszW
         xxwW8pxiFHJ1PWqkODixsLPeZcboekI6aXbpoPGqZtlsO7J8bpi0BdgKuJVL4bGFPZDA
         WKXA1Grc5L/3sv4XHw7/oOgHg4YiV8nHptzRpGO6iEAyPlFVC9clcfXKQVOzdrV3+YWD
         DxdOgImZ5EPjnCF+l/MMCRSfGFk/FIVHBjblRqnf6s9SD3xjtdxx+Xg31ldhG+vF9OqT
         rj/+7pm4Y8ZFohF1OEJDhPR6Yyz8izoyRV9Q5yoLNfA8TMnzo3/IjLqZ4iVL7QqlMapD
         ISqg==
X-Gm-Message-State: AOJu0YzKTU9LX7Dmnah7KL4iQeqPEMALsbJluSlUUIK3XrKmxkeu6rbW
	gxAAKX3lJeW41iyt8KELWQichICdog8=
X-Google-Smtp-Source: AGHT+IFGb0Gf+N4OcikIO8aO5+LAm1koSdTrmM19+4m1HJVUMK+YbypkHjjxScltKICbRwHDxbzUXw==
X-Received: by 2002:a05:600c:1c14:b0:405:3ae6:2413 with SMTP id j20-20020a05600c1c1400b004053ae62413mr7011085wms.25.1700514705446;
        Mon, 20 Nov 2023 13:11:45 -0800 (PST)
Received: from solpc.. (67.pool90-171-92.dynamic.orange.es. [90.171.92.67])
        by smtp.gmail.com with ESMTPSA id l22-20020a05600c4f1600b00407752bd834sm14709296wmq.1.2023.11.20.13.11.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 13:11:45 -0800 (PST)
From: =?UTF-8?q?Joan=20Bruguera=20Mic=C3=B3?= <joanbrugueram@gmail.com>
To: Arsenii Skvortsov <ettavolt@gmail.com>
Cc: linux-btrfs@vger.kernel.org,
	Wang Yugui <wangyugui@e16-tech.com>
Subject: Re: [PATCH v2] btrfs-progs: receive: cannot find clone source subvol when receiving in reverse direction
Date: Mon, 20 Nov 2023 21:11:22 +0000
Message-ID: <20231120211123.916332-1-joanbrugueram@gmail.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <ce4f7788f24442cd6f4779baee1992bb1978b85c.camel@gmail.com>
References: <ce4f7788f24442cd6f4779baee1992bb1978b85c.camel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The first parameter of `search_source_subvol` should be changed from a
`struct subvol_uuid_search *` to an `int`, which I suggest naming `mnt_fd`,
otherwise this generates some integer <->pointer conversion warnings.

(Note that there are two different declarations of `subvol_uuid_search` in
 btrfs-progs, which probably caused the confusion with the typings).

