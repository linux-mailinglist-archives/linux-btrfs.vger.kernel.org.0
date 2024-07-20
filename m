Return-Path: <linux-btrfs+bounces-6628-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63E5A938234
	for <lists+linux-btrfs@lfdr.de>; Sat, 20 Jul 2024 19:00:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1ED3D281C11
	for <lists+linux-btrfs@lfdr.de>; Sat, 20 Jul 2024 17:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A63B1147C80;
	Sat, 20 Jul 2024 17:00:15 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 433F514387C
	for <linux-btrfs@vger.kernel.org>; Sat, 20 Jul 2024 17:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721494815; cv=none; b=V4WrfF8nEoU9Bw39YKSlTp33jyr2IRdqAvRT8HF7LwlxJ17iTi5Rg7DhAwf/lbr/tVFeRh6lXYwOJvrKUFuFE+w/WZKeudEo8iEq6xeSA1GrWu3HU4cz0JC/c91eWN7ONLiwnFa68jBe6X3HN6DTfXzr6NJJS+AB9VMysy+Owf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721494815; c=relaxed/simple;
	bh=1fvJ7uh7Vnk3ec4hnqjbqTU2lNSAshSRvjiCMwgxfu0=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=pXndURps/c514OdazCyXjlqXVrYBeACmZ5M872QHRdL6lSnMkLNuYXd5ii9x1Z+nO6HOZsuboJaBNL3xocIeLJuKAd0yYjED78ksGq96tij4AIIGtKk6QiBQjS4Jx6EU478BtPVyBanoNISIBk8iBqGWJlejKSAieN1OCM5TwYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gompa.dev; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gompa.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-52e9fe05354so3420402e87.1
        for <linux-btrfs@vger.kernel.org>; Sat, 20 Jul 2024 10:00:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721494811; x=1722099611;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1fvJ7uh7Vnk3ec4hnqjbqTU2lNSAshSRvjiCMwgxfu0=;
        b=nuVJM0O8UUnc5t14fwxkiksRw4rkrrgOEGQxEzE/J5q7mpShWeec1RHK4a21tRaIRt
         X+2yn+R+i15KQ6Px993GfY/Hzbgbo1MRYm2yEsMCjgZj2faISUBXVXlvHF9Frr7PSwD8
         I+cqaHvx6DTPriGewqgf4Gp4HjuJ/9J3/zAlxuXg2xrgXYpF+meEnQzt+8uJLvvN0E4J
         YzWPlOScLovnmPS7J7gsO6h2iegXDCot4DIxLQBJLJXAnNobpwVWofJBKy0+9q66PeVQ
         /AQXza8xK6Y2A4fD236ZJlvHcJ3MmKVFQKnQjISvGKdmU0t8c9yF7j9LhMHrRcPYuU20
         Msmw==
X-Gm-Message-State: AOJu0YxhN/ikZHgTTBnl++wIh+d7szKeuv5dZLImQCsAnCJNnSiv6RHF
	CaJ8ca85y//neme1gW4J1mxsqAOONHY89Rq4dLB4BS8ofcorB7mue8ZqK1Mf
X-Google-Smtp-Source: AGHT+IGh5gH+jTFjClJAKotQrRoLfuQeQdPvQCeV+1W76opB04LP5t290jFD+b5808IQH4yYtfwAPg==
X-Received: by 2002:a05:6512:b21:b0:52e:a60e:3a04 with SMTP id 2adb3069b0e04-52efb85af78mr1425683e87.59.1721494810885;
        Sat, 20 Jul 2024 10:00:10 -0700 (PDT)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52ef552c4ffsm564781e87.20.2024.07.20.10.00.10
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 20 Jul 2024 10:00:10 -0700 (PDT)
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2ee9b098bd5so39202171fa.0
        for <linux-btrfs@vger.kernel.org>; Sat, 20 Jul 2024 10:00:10 -0700 (PDT)
X-Received: by 2002:a2e:7012:0:b0:2ef:284e:1d07 with SMTP id
 38308e7fff4ca-2ef284e20edmr3168981fa.13.1721494810341; Sat, 20 Jul 2024
 10:00:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Neal Gompa <neal@gompa.dev>
Date: Sat, 20 Jul 2024 12:59:33 -0400
X-Gmail-Original-Message-ID: <CAEg-Je-tu0DcYvH-mqcv=2xkReYOh9GaeVoJPy0nMD=oqO6stw@mail.gmail.com>
Message-ID: <CAEg-Je-tu0DcYvH-mqcv=2xkReYOh9GaeVoJPy0nMD=oqO6stw@mail.gmail.com>
Subject: libbtrfsutil Python bindings FTBFS with Python 3.13 on Fedora Linux 41
To: Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Cc: Victor Stinner <vstinner@redhat.com>, Miro Hroncok <mhroncok@redhat.com>, 
	David Sterba <dsterba@suse.com>, Josef Bacik <josef@toxicpanda.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hey all,

Fedora Linux 41 has upgraded to Python 3.13[1], and as part of it, the
changes to the interpreter API to remove "private" methods have broken
the build for python-libbtrfsutil. There's a downstream bug about
this[2], but the gist of it is that _Py_IDENTIFIER and
_PyObject_LookupSpecial were removed[3], and so the bindings code
needs adjustments to fix it.

Anyone know how to help with this? I'm not really sure how to fix this...




[1]: https://fedoraproject.org/wiki/Changes/Python3.13
[2]: https://bugzilla.redhat.com/2245650
[3]: https://github.com/python/cpython/commit/4fb96a11db5eaca3646bfa697d191=
469e567d283

--=20
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!

