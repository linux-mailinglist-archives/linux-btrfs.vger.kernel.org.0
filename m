Return-Path: <linux-btrfs+bounces-1478-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66EA282F23E
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Jan 2024 17:17:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0615C1F23A5C
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Jan 2024 16:17:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 501381CA87;
	Tue, 16 Jan 2024 16:17:47 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from vps.thesusis.net (vps.thesusis.net [34.202.238.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71EC11CA80
	for <linux-btrfs@vger.kernel.org>; Tue, 16 Jan 2024 16:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thesusis.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thesusis.net
Received: by vps.thesusis.net (Postfix, from userid 1000)
	id B120E153765; Tue, 16 Jan 2024 11:08:40 -0500 (EST)
From: Phillip Susi <phill@thesusis.net>
To: Michael Zacherl <ubu@bluemole.com>, linux-btrfs@vger.kernel.org
Subject: Re: Checking status of potentially hibernating encrypted BTRFS?
In-Reply-To: <70AC3CE8-D407-4409-AAB7-1F1FF38A7ECE@bluemole.com>
References: <70AC3CE8-D407-4409-AAB7-1F1FF38A7ECE@bluemole.com>
Date: Tue, 16 Jan 2024 11:08:40 -0500
Message-ID: <87cyu1b6rb.fsf@vps.thesusis.net>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Michael Zacherl <ubu@bluemole.com> writes:

> Hello,
> after I accidentally rendered a system with encrypted BTRFS un-bootable, =
I=E2=80=99m trying to check the state of the BTRFS before I try to mount it=
 externally.
> After some intense experience *) I=E2=80=99d prefer to proceed very caref=
ully.
> I=E2=80=99ve to assume the system is hibernating, so the FS is not in a c=
lean state.
> In order to fix the system I=E2=80=99d have to mount the FS externally.
>
> What=E2=80=99s a save way to proceed?
> Thank you very much!

If you must mount any fs from an external system while it is still
mounted by a hibernated system, the only way to stay safe is to delete
the hibernation image and never try to resume that system.


