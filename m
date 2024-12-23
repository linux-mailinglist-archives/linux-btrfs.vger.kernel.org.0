Return-Path: <linux-btrfs+bounces-10639-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 327A19FB04A
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Dec 2024 15:43:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18F321659EC
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Dec 2024 14:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 231E2194AF9;
	Mon, 23 Dec 2024 14:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="LW3Uth+7"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-0201.mail-europe.com (mail-0201.mail-europe.com [51.77.79.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8785817BA0
	for <linux-btrfs@vger.kernel.org>; Mon, 23 Dec 2024 14:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.77.79.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734964987; cv=none; b=FTxW3GjF/p/VSoKWl+CbqKNHB31hnTQvJrYQKS85Jp7idvTbvnanSYJE6M9G12nmpnxmvzxl+zzCugVYzc+6a4H5x8KeLDuwLHSvAMxMjIwHMPz2fsdeRYh3ucUN9yCRnvzcaImChvLy1UtYebcWpj0ynNVG3Ts4iqQuL/a3+aY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734964987; c=relaxed/simple;
	bh=qRRJJN3XMa/i9Th1NkUOppweDxXLfhosNfIV/KgAZy4=;
	h=Date:To:From:Subject:Message-ID:MIME-Version:Content-Type; b=Yamx7Pn8pEwfbHSkUheuh50jhmwRZ1GQqLH+rEi2W1gcwHfDrzQnVnUK8C3B9WSmIcILRlRZZytVmdrJAcDkYidbzEm/0dAntLn7oK0jZ/jiwSc1hG/WE/GSiwetyjYqYQ/VCj+NPk79123455WBXF/ei41c5da7qBX+w0g8S9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=LW3Uth+7; arc=none smtp.client-ip=51.77.79.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1734964975; x=1735224175;
	bh=qRRJJN3XMa/i9Th1NkUOppweDxXLfhosNfIV/KgAZy4=;
	h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector:
	 List-Unsubscribe:List-Unsubscribe-Post;
	b=LW3Uth+7nj+TNcKuDOXoQiomXDqJbbyjkVYjIjCWTNsJ8gOiFtB6eLLRfE7K55ZAl
	 OZrhpnlxkxBiglCmM3DAExcml37SNLKsyhsRC82WIqh6ZhCDhKzU1JqUkTAZlbhxdt
	 5ZM8W4L/EEo/GjVSa23LwS5sJqcr5pkL/OvgjdAHbpLbzmwH1BOciC3LkOVHdlDBRv
	 AB03Aaa5LJ1TDzSFlqIG+KZT/YuMKLE7qnbt820V82Yy7QWaDxF+Ik+wCGLY5SHKwI
	 w8d5C1s7/yeoPOLBGAGrnLP4J/O4S1ySoeZKKRRrx25tx8GvOXcpHZShrYl2/M8kJk
	 OZdw9PAOVOuXg==
Date: Mon, 23 Dec 2024 14:42:52 +0000
To: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
From: Rupert Gallagher <ruga@protonmail.com>
Subject: Help with data carving/recovery
Message-ID: <TfCR_aAVEaCerJrieO6DxVpefzzfDfUuPKa0_ejDwu4gqc4CjKjRJknfRT2ZGyfM477Eu9e3bm_KtWn_0lrrvL5P3mDPKX-Ko0btFiO7Vzc=@protonmail.com>
Feedback-ID: 945109:user:proton
X-Pm-Message-ID: 0d56accaed908e8eceeed9485722ab871a870368
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hello,=20

Is there a method or tool for data carving or data recovery on BTRFS?=20

As an experimemt, I deleted a shell script, and unmounted the partition. Cr=
yptography is enabled. Snapshots are not enabled.

- All open-source data recovery and forensics tools I've seen just use Phot=
oRec. Although PhotoRec recovered many files, it did not retrieve the wante=
d one.

- https://github.com/danthem/undelete-btrfs
finds the file at depth 3, but fails to recover it, saying the file has zer=
o length.

- Direct file carving using grep finds an old copy of the file.

Is there anything else available that leverages BTRFS specific security fea=
tures?



