Return-Path: <linux-btrfs+bounces-11374-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F12FA30BA7
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Feb 2025 13:22:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF4423A2D16
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Feb 2025 12:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8821C1FC7F5;
	Tue, 11 Feb 2025 12:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=massimo.b@gmx.net header.b="nA5gADUY"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B3B81F3FCB
	for <linux-btrfs@vger.kernel.org>; Tue, 11 Feb 2025 12:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739276516; cv=none; b=BE80qXqxBmCkP0oxgNRWvqotCmA7bIg7RCqXH6UoHTSQFjHY7ZbobuRbrDRYVsbjPUV8it5gwbQTfA9YTxYuX1ewDGyZeWvymfr2r8I+bwDFxyyj80wyW8IVoOs+H5G1neB4sCXJdPaeA1bKzcv6WiYnhY5u1gqistBsK92g90M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739276516; c=relaxed/simple;
	bh=XR2P0/6utBOArx0TURhXeBKEP/qVOyZOtEAf2XqPmE0=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=c0ddGyjC39SFsHQ+fIxB5dye9+7VLX8TFzhXdIQTBDCxqyj1/LeFUOMDMLIcmJKFUuNftLCZz486rgoBq8R/f/cmtRuTF9/hCkkW7Q9kHchen/SnjnEKMu6UzIs9FrjSykfcHHj/7Q5uhu5TE2CdDJKtBPZB9kmiSiEt10SYmj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=massimo.b@gmx.net header.b=nA5gADUY; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1739276512; x=1739881312; i=massimo.b@gmx.net;
	bh=XR2P0/6utBOArx0TURhXeBKEP/qVOyZOtEAf2XqPmE0=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:Date:
	 MIME-Version:cc:content-transfer-encoding:content-type:date:from:
	 message-id:mime-version:reply-to:subject:to;
	b=nA5gADUYqciEX+tGc8r9uOuXd1b3+cRLLbYSPnHnw+NRR/c2jl2ZvVILtzEX5J5G
	 yhs+jF5er96H5NaBzUdxFkCm3+PkMF7AdNtYYxw5FwPKeE8JBLNlpOPFU3jWcq/9l
	 +1XrQHNT+dXYTIuW+ghMOqLsndYdyaO8yqdXnQWoFPJe2OWK/k1gTnCc8LIFDAK3z
	 0N0HBCEBpNRI/mzLY4KFZ5e9eKdJxHTUzF8SaeeEnvjOoulWmaRR1j6wGt9tV5FA3
	 muKtioR+JnNb5SnlLCLdWFUZCYyyrwlHCKFCbxUX7ZqalGuChoVrQOvtkTbRtl6UD
	 6NkqKvAU62NBUzU28Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from gmb ([176.1.3.251]) by mail.gmx.net (mrgmx105 [212.227.17.168])
 with ESMTPSA (Nemesis) id 1MI5QF-1tdlCR1wM3-0024AD; Tue, 11 Feb 2025 13:21:52
 +0100
Message-ID: <0e280655e6da59265b8de5a686b6f8c825ab4b1c.camel@gmx.net>
Subject: Re: Infinite --repair super bytes used mismatches actual used
From: "Massimo B." <massimo.b@gmx.net>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: linux-btrfs@vger.kernel.org
In-Reply-To: <4d7d8b4036327081418f54b55cd47d90fc2573b0.camel@gmx.net>
References: <aff8355c64d68b4995cca0a132d35af527e160b3.camel@gmx.net>
	 <427384fb-0e23-4220-8a91-b94c3b99a6a9@gmx.com>
	 <4d7d8b4036327081418f54b55cd47d90fc2573b0.camel@gmx.net>
Face:
 iVBORw0KGgoAAAANSUhEUgAAADAAAAAwAQMAAABtzGvEAAAAA3NCSVQICAjb4U/gAAAABlBMVEX///8AAABVwtN+AAAACXBIWXMAAA7EAAAOxAGVKw4bAAABGUlEQVQYlUWQsUoDQRCGv71LjB7KSSBwwZCTgFhY2EYIHmJnZRMLo5AXUMRCBMHcE6iPoGBlINpoZXGVeQTFKqSxMgYtTBFcZw7EKfZn2Z2Z7//hr2ysZ+5tqFLmWKVaKKs0vWd9TJx2AibmoQcupj6CCZirqTgzA5hmsdtQWe5/xAREX7uJ3MLP9x4lyieNO5mcOxyM8HH79y/4Cdn9R3JDsts/uGO82yOMJf/ah1Y8tfQEIQt7Z7rCawtNiUpHFgYUdgTxgI1NAW6SvxoqWabbw0Bd5jpQibTNBC1F4nIMk2TWhTqIs+fSVpzfCsVR9eaiJf5W6mtWXK7O+vKR4nWkSYSuFbP4No3Ht6dpSN9pSMYmaXI1/usXT0FM3SoTKAAAAAAASUVORK5CYII=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 11 Feb 2025 13:16:51 +0100
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.52.4 
X-Provags-ID: V03:K1:5CVn7Fi7/WgHbmwLgGMq3pbQvBl0pO3u0UZJkQKbBoFXET2i0aX
 EOBrCe+87y09CZnQp+Pt6biF72kFO0LEkJ+ozFeKa/uxJhhDZVZRB3NgbTUUoAdWy9thNT0
 2XNy0f0dh78PMuS2ph3+F5rw3HHX5VYu2K853fqNNWHTr48ds0Agiw2SqRepHfsqy4pohdU
 ycmFRd1dpNQyrnViVJEew==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:20WyH+l16/E=;IzLfU++fD+XrgxduMZVmXvSy8GU
 ZLQNJNqSCl4+M17OWG75lE23iPvRIRmDK1/BQtuqnAqWIw3CwI4JIK4y3rQq/WvvlAemZmdCp
 vzqHpO8MY/Fr1Z0llUw+f4al+PMIrVFQo0Ne71Ho5AHnBDhkwRb3LWBgj5TY830DdLg0ClxIX
 suJN8ZTBbyAtiLtTQQ/tGkOcTanC1pUQZpEcXXjTRklJoMeonTJzGqAE2di4/iVNO8ztkspaP
 Tb2xcbA6a2IibEmGbB+SDMWEN5sHSWA9vGT0BL/BRG1Hnb0DH7fvHuPfNRiSCEhzSDHhFUopF
 MT8WGbUKm7pvgkpHZJoBUMqY72dpwF96YYzg+sF7Asv1CVu2rkVEmL5J4TvZff0RrvZ/BIpjt
 esExcBe05zoV+L8ih+0qKF5noOxTurkRUeBBbuxGqZ6VuHsb14IIT/soN+j7qgbhQ9TGarceX
 /AXshz+9ggX3EywIPgdlnH9C0DYB3tYT6lZIDRvTAdi6ScGsSj08lz64imIVya/y7K+qbEpYk
 ffQgFBJ0qgXofwkDm6SR2lN97k6shDTwL+2IJPUxaGKyI68FbABhO5bj0rtqsI0y1dkspQO8N
 /BhUxH7OpKQrFxCdAuekN3npYjC7TacSD/686roikoSepRz4T0++jBemFZ4PLrMQEaFfa0/g0
 VHbZDlJfXigPqZQV9hXeMmB9C/nVOSUjRjiNZ4cYmw0iy3EWCzgE1NcIGLl6Gaq3YR3ECm4lf
 AyqB8a7R8mDCL8H5ssiFUhiOlqWTSzVGyUZzrgKr2Pe+GWNEkrqaDZJFyXvBxAqTrfYkXq+FX
 dXU5O500Fk/w/dCjIbOFkKyU8NGizmqd7NhI2M/WPMSMifyCvb3Hvr04zxryC34r4sda8lolR
 cWLWRMAg1ZVFtOi88tC7qfj17i7K6Y/C/LJ1gUlSNSrik5MZiSTseGz6thyVxYMq9BVvlGc3A
 y4SNv8iXYb9ZmWUvYuA7nwE4D7tSlHCQSYQF7H4VNDZK96gpu2kBWGywkDCM72oBTt03AP2k+
 SKZtG/zjkvEW3lib4rfCzmlBnO/KyasEdkbP0K4I+1R2CdqB6JBUS7RvClcxNCtmv+uchIapJ
 EYm+97OUqMXibjHNoOGDbjMJ8f2jebJPtcplPB/y+67NoTQAg1z7oHh5NlS9e7jqWA/Etd0dF
 9aMhRMUCTwxZx2amaEmgyyIbIKmFU4NzVbvihKvFgEoXjXZOnIZ5K5s45arBsk61ik7i/PwGL
 UOXN7riYkOHonAIGcfisxX8nwzciY1nWAftmNjECEtvfayQIxECt88OTdy3GmlT90e8rCE7nO
 ROPWOC67zr06VAu5jmdDpSAOX0Fq/jsvlUMg6lvZug1J0eKVvgNEKeKjEwB+2vyv1U/g38Uge
 KCj3yG2O9deHExRKwT+wS51FJIjWxbsXD82SjBHpZ6SqI/N1hwsCHTTNmH

Also mounting with skip_balance turns the mount into ro after mounting:

Feb 11 13:09:16 [automount] mount(generic): calling mount -t btrfs -o compr=
ess-force=3Dzstd:19,skip_balance LABEL=3Dlocal_data /mnt/autofs/local/data
Feb 11 13:09:31 [kernel] BTRFS: device label local_data devid 1 transid 153=
304 /dev/mapper/localdata_crypt scanned by mount (4694)
Feb 11 13:09:31 [kernel] BTRFS info (device dm-2): first mount of filesyste=
m ...
Feb 11 13:09:31 [kernel] BTRFS info (device dm-2): using crc32c (crc32c-int=
el) checksum algorithm
Feb 11 13:09:31 [kernel] BTRFS info (device dm-2): force zstd compression, =
level 15
Feb 11 13:09:31 [kernel] BTRFS info (device dm-2): using free space tree
Feb 11 13:09:42 [kernel] BTRFS error (device dm-2): incorrect extent count =
for 213705031680; counted 8054, expected 1351
Feb 11 13:10:45 [kernel] BTRFS info (device dm-2): balance: resume skipped
Feb 11 13:10:45 [kernel] BTRFS info (device dm-2): checking UUID tree
Feb 11 13:10:45 [automount] mount(generic): mounted LABEL=3Dlocal_data type=
 btrfs on /mnt/autofs/local/data
Feb 11 13:11:21 [kernel] BTRFS error (device dm-2): incorrect extent count =
for 213705031680; counted 8053, expected 1337
Feb 11 13:11:21 [kernel] BTRFS error (device dm-2: state A): Transaction ab=
orted (error -5)
Feb 11 13:11:21 [kernel] BTRFS: error (device dm-2: state A) in convert_fre=
e_space_to_extents:471: errno=3D-5 IO failure
Feb 11 13:11:21 [kernel] BTRFS info (device dm-2: state EA): forced readonl=
y
Feb 11 13:11:21 [kernel] BTRFS: error (device dm-2: state EA) in add_to_fre=
e_space_tree:1057: errno=3D-5 IO failure
Feb 11 13:11:21 [kernel] BTRFS: error (device dm-2: state EA) in do_free_ex=
tent_accounting:2887: errno=3D-5 IO failure
Feb 11 13:11:21 [kernel] BTRFS error (device dm-2: state EA): failed to run=
 delayed ref for logical 213854011392 num_bytes 16384 type 182 action 2 ref=
_mod 1: -5
Feb 11 13:11:21 [kernel] BTRFS: error (device dm-2: state EA) in btrfs_run_=
delayed_refs:2184: errno=3D-5 IO failure

