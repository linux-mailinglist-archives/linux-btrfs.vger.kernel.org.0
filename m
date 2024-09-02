Return-Path: <linux-btrfs+bounces-7738-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE47F968B25
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Sep 2024 17:35:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85ADC1F22E08
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Sep 2024 15:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1576919F139;
	Mon,  2 Sep 2024 15:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PzT2S4uA"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF36C1CB51D
	for <linux-btrfs@vger.kernel.org>; Mon,  2 Sep 2024 15:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725291351; cv=none; b=Vnkd1UKhK+uNUW6Nv473M7PZxAHDqWvSHavpN/US16or3ECW4iDkbwn0wQCd2fAwKA3L524e8kodlg2gtU/VFJUtFKGHNyYClQHgGPlXMHuOncccX4ud5WdJSPqNQfL2SAfIMl30u6UhNxqseKVIsHHzhFF6XBEQqcsuj+SCFu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725291351; c=relaxed/simple;
	bh=iPXCOar/Tnkbj3tEorIEqKwz0inieI8Bd67+Kub5ZJ4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=KkZYU36tZNTfwHZHl6OuelHexeXx9dD3MI4g0+T3VGsvqBiVwESwbWmD8IvS81cgGr5yE9viBETbdYb8LjnWcbOeMtQUy8q4/LkIgCNYYzeFdmVxusfDIbLbOWA0QVrjjnURxAfQD0+5OtzeKxbQBP3HVfezpiuruCZk1YV4gbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PzT2S4uA; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-374bd059b12so1364441f8f.1
        for <linux-btrfs@vger.kernel.org>; Mon, 02 Sep 2024 08:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725291348; x=1725896148; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vCv6pFkc2SvzEY5Yc+0MzR2Lyj+pyhMc0VgWMqabhcI=;
        b=PzT2S4uAigeZL+27onXZr9g3iRax8PvWEz6vJEHPnmJlh0fcOeftI+miuCxc1XbVO8
         b1kNdtuSdc2lq6Rjy2p6o1dKOZItdPwmfUoQ5V7FD/uBgcmelixjggnzKTxs7q04HbyE
         U8NIfhnKu47WpamzeRIeuny1HZkDBJpErkD3AD9r6qOeOjvTmkdlxwtSIo0VXlRhQzHF
         chhWXumpDIumz/o0J053GqgWmxIx+fCppbJ2RqMEvrt9jPNO1l0e9PPbVYETujPYLbLV
         jyFc1NECHezkILSn0SOr7nXp7DMCxC5mUs+PceMzasxKh8rbO0yPSFa6V2sxUhfCbpeR
         r3uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725291348; x=1725896148;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vCv6pFkc2SvzEY5Yc+0MzR2Lyj+pyhMc0VgWMqabhcI=;
        b=fIZwWELTeAu/TZRqN/BINmZM/mIBqIr20IBrQc4wz08wr9YoZhbVV5HtC/v3OvAkTw
         G3n4+hjvK0v5TdQLc5TiF0mySaaPEsFUPwkLMZZZBe5VItvr6T7REqbl/CC+glC3o7Ee
         V5pDw+jpavBTBv58khZxb/2367CUYF+jSeDcboGT7R21jSZOAE03ogxeBswLG5k7VV9s
         SmfRc5AqRm+wXdrpk4SLMBvxAfOY2JPSqYTGXidpP6nIJ00kOnxqAv6QNnrCoMJg4/+x
         gFkUcFfSeaZOwy+YIIYBcca08/Rl1W5I10PiqAc9lSIt80Ve3MxSKwMK9c4ytzVtM5+P
         BFow==
X-Gm-Message-State: AOJu0YwY5sj6Y3S1F89EyHPP4mZyY18tz8ynXICe27Gaxu9Aeeh6PeIJ
	C2o6GM2BXa3saxix89LjBGtu5JxollsDpVrTvHeru9hWFYdM1JNUp9rJzFQ+FDd3tDd8RvaFvus
	/yMbd2jfHzJ1MXN2RrOcjf3QQ22RPhzuB2S4=
X-Google-Smtp-Source: AGHT+IFq0bQwbkwj2EINocSsDGpDl9tEcDMI8yJuNvsJUCKgY2OC206a03YSVOCGM5tAa9MUlCKUfu0Ay+41Y6sQotk=
X-Received: by 2002:a05:6000:144e:b0:374:d2a3:9806 with SMTP id
 ffacd0b85a97d-374d2a3989cmr528208f8f.2.1725291347651; Mon, 02 Sep 2024
 08:35:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Xuefer <xuefer@gmail.com>
Date: Mon, 2 Sep 2024 23:35:35 +0800
Message-ID: <CAMs-qv_QuHCA2pU4w4fiQbqnvo2PikmhM=AE+YrNzLsKxQ149w@mail.gmail.com>
Subject: is conventional zones used for metadata?
To: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For zoned devices there're conventional zones and
Sequential-write-required zones. I use btrfs on HC620 (HGST
HSH721414ALE6M0). The conventional zones are about 131GiB in
total.but.My disk metadata is using 13GiB which should fit into
131GiB.conventional but it uses a big size which causes unnecessary
big unusable zones.

    Device zone unusable:        728.00GiB
Metadata,RAID1: Size:736.50GiB, Used:12.62GiB (1.71%)
   /dev/sde      736.50GiB
   /dev/sdf      736.50GiB

this behavior make me wonder if btrfs take the advantage of
conventional zones for storing system/metadata data

