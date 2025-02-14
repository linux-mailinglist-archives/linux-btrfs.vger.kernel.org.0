Return-Path: <linux-btrfs+bounces-11459-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 818F0A35617
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Feb 2025 06:15:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36662188EC1B
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Feb 2025 05:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6AEA18A6D7;
	Fri, 14 Feb 2025 05:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="O5YLkQ4s"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F3A618A6DE
	for <linux-btrfs@vger.kernel.org>; Fri, 14 Feb 2025 05:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739510104; cv=none; b=IsvOoyrwKsQuOcPFQ4R4aw8ZM8UMR9hiVq4W/V4elMUFKgVnJyf1v6eWhgRCdklQz0T3aS1adakNE56/ov2tN+G6vHcTjUBebYldUgiwj0XtoADct5NfkZIZY1Xd2+VBcK63OxCQ0OD2D3UTICERWJS2I2rH1HLVZV/5eazxPVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739510104; c=relaxed/simple;
	bh=c0X93Q0ztaryezJ+X7Lf6g9+DVFUPWP3d6uoFLfYj80=;
	h=From:Content-Type:Mime-Version:Subject:Date:References:To:
	 In-Reply-To:Message-Id; b=VOzeCsgzxBRNCDzBFHRVUEwkX7W2ofVQCVVTuGcPyLVZ1b/CdRDQHZezC9MCeV+8aQ9/xA/szXJtzZT3Nx7Tx+9LZaxc3hXj4ZF/umqTnVi/NnQFid9dIy8hLg8QuoQlG4J7wc7y1p6YwjdGWEFLHFtqJUGSp9e8koikDSbyTmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=O5YLkQ4s; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-38dd006a4e1so1202852f8f.1
        for <linux-btrfs@vger.kernel.org>; Thu, 13 Feb 2025 21:15:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1739510100; x=1740114900; darn=vger.kernel.org;
        h=message-id:in-reply-to:to:references:date:subject:mime-version
         :content-transfer-encoding:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2AzdpWaXSjByLUDshVrJOMJ7eb4UI/Zyo1x4EBg6AU4=;
        b=O5YLkQ4sG6YEOCDexE+dLnEr80j4bTVnjjyw5+tO93sl3UEGPvtuVbcNFQxZ1zI+83
         OkKNU45O68Vqf4YoVLrloS23awDWDii7n/pG0pctURYF1Bdzq8APIVtXakLNbeEbAQ8h
         0AJ8fPvoyDkkUdYNZuR0M+iBdhVvTFOultWuTUFuQjLe6pfHC9wEdwfB5W8cZKpRZnJP
         kOBIZNZu71fJIA7kYowC1wmeYnZdqGcgnSD5yYzQAFlp6DLI50MjHomFcQdJpKnJKskE
         nvxXZTiV5LWsjlj1IF9t1X8UfWRyPs+ohqdRhmPCFzMbI/07l6/08V+MVMEYbI0RCLRC
         FK/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739510100; x=1740114900;
        h=message-id:in-reply-to:to:references:date:subject:mime-version
         :content-transfer-encoding:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2AzdpWaXSjByLUDshVrJOMJ7eb4UI/Zyo1x4EBg6AU4=;
        b=ZfNb37cc/Kq0MusYI86ZkK3tiW/WYY6bbMw+nQeZy0s+XbBjgIfHmlQo7h5olKmpAU
         z1By0Qdm9myj6RzyZ41G5t/J4SQDAnmlyJ77+gtKrGHEkyU47hVOjxceIjyXKvQB1VvH
         6QH/GDHe/bVIQ/UjUPV2cwXitEeYAlQfHED5L+fT+FdsdUt+jBmA9l4sLhS7ysJ1Er+/
         w9+EsDlefBrQHboENTAIZZp0s7Wpo77C59LFdcOuxRUIagGwNwMMAwOZX52pWZjXdcCx
         DP+XJlFLsoiFxmrOd+fJ+h/qf3Kimbksd70J8QnTMaZWG8qVMUOfEj76eeZ2KxW78lH2
         a4OA==
X-Gm-Message-State: AOJu0Yyj0JwikxzSajGS1HybMLpgeFWqmzq2jSzIsrQBk0hFqQI5qy9R
	+d9qI/K4iGJkPTpUA0u7B133Ve6Zt9rH563835CqAouTOCthq0pa4nSfirfBRjNi75c+HmYW3RA
	T
X-Gm-Gg: ASbGncvDSSIuIcLLyN3KdBEN1dL3uJgi5HMa3HQCsR0KinzIBE+aQr8bLV+x1KyKEqj
	HjIuj6Zvcl/KMiQODDRTuFsSA/4GyRYn6Q8lP8wYXB4khc6+iYb9qun0VZYnG2GvQQt82EgTysZ
	8Cqmg9i94I11hBz4kJ94gxXL7ALr5Yz4PF9YZbxrfetkn+Ce2qa+O+WNat2Dk5xvGGK+3jmaZ0e
	6g3LzSyK/E0tEPYI7aMC7YUBZDUf8+SjOc13zJsoeLl8Ddx3ipm+ucq7YaUmH1TRHlTkFHT0Gyd
	d7CWwRzE7B6mk0BBqgY=
X-Google-Smtp-Source: AGHT+IFqrrOAUIBJKWX5a9AbjT2/loOUFdO0KkVRXCt21TUeaQWwNLYVAHR1ocpJPK087oTXE75aqg==
X-Received: by 2002:a5d:6489:0:b0:38f:29a5:479b with SMTP id ffacd0b85a97d-38f29a54c44mr3901973f8f.6.1739510100644;
        Thu, 13 Feb 2025 21:15:00 -0800 (PST)
Received: from smtpclient.apple ([195.245.241.170])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7324273e4d5sm2234070b3a.86.2025.02.13.21.14.59
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Feb 2025 21:15:00 -0800 (PST)
From: Glass Su <glass.su@suse.com>
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.400.131.1.6\))
Subject: Re: [BUG report] fstests/btrfs/080 fails
Date: Fri, 14 Feb 2025 13:14:45 +0800
References: <30FD234D-58FC-4F3C-A947-47A5B6972C01@suse.com>
To: Btrfs BTRFS <linux-btrfs@vger.kernel.org>
In-Reply-To: <30FD234D-58FC-4F3C-A947-47A5B6972C01@suse.com>
Message-Id: <8C3B26C2-A6D5-4F42-B850-80880A0DA422@suse.com>
X-Mailer: Apple Mail (2.3826.400.131.1.6)



> On Feb 14, 2025, at 13:11, Glass Su <glass.su@suse.com> wrote:
>=20
>=20
> Hi
>=20
> Recently I found btrfs/080 fails like:
>=20
> btrfs/080 124s ... [failed, exit status 1]- output mismatch (see =
/root/xfstests-dev/results//btrfs/080.out.bad)
>    --- tests/btrfs/080.out     2024-08-29 09:10:14.933333334 +0800
>    +++ /root/xfstests-dev/results//btrfs/080.out.bad   2025-02-14 =
12:53:24.667572260 +0800
>    @@ -1,2 +1,3 @@
>     QA output created by 080
>    -Silence is golden
>    +Unexpected digest for file =
/mnt/scratch/12_52_59_984815662_snap/foobar_39
>    +(see /root/xfstests-dev/results//btrfs/080.full for details)
>    ...
>    (Run 'diff -u /root/xfstests-dev/tests/btrfs/080.out =
/root/xfstests-dev/results//btrfs/080.out.bad'  to see the entire diff)
> Ran: btrfs/080
> Failures: btrfs/080
> Failed 1 of 1 tests
>=20
> It can be reproduced once in about 20 times on v6.13, misc-next(HEAD: =
1c08f86eeadab89e8f6ad8559df54633afb7a3ba)

'misc-next' should be 'for-next'.

> in my VM with 32 cores.
>=20
> Configs and log are attached.
>=20
>=20
> =E2=80=94=20
> Su
>=20
> <btrfs_080.zip>
>=20


