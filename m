Return-Path: <linux-btrfs+bounces-12101-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F235A572D8
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Mar 2025 21:16:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56B743B879F
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Mar 2025 20:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01C7024DFFE;
	Fri,  7 Mar 2025 20:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lm9/pMOV"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B86531A5BBD
	for <linux-btrfs@vger.kernel.org>; Fri,  7 Mar 2025 20:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741378566; cv=none; b=img+BuhwFZBHzQABXHKScm0X5RSxqlxSEVk5+e66HELfNRUDjhfqclCj7+tjh7J7ZYJmx3DHKgaMTpahrYmh8FA4Kf6NmewMpXQ6wTs/Z/HPB8H9lY7VYzZbmYE7jhB5i0VSVx/nZGIqAl/7kFrHw1fcC8WpRhRqCb2mcoiD3YM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741378566; c=relaxed/simple;
	bh=VY6NFxAT2L4rXTh1KfeRDraEVjMXEet/YFF33JXDKYA=;
	h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type; b=dGxhC5BEcDwt0N6GwJ10Y7VnTIyjLSmVp3mKJuXYJf/3hi6LBWjCzx877Xk9Vmu9+rohc/qjA015VSk4A2QecoKS+o+yEVzFoLmzVo4ibfgA47zlkzzOWQ9sFClmklPkZZKSAX1aHupEuIAkyHB75NDzL4YbKW74lTke9/0HEUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lm9/pMOV; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43ce71582e9so294995e9.1
        for <linux-btrfs@vger.kernel.org>; Fri, 07 Mar 2025 12:16:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741378563; x=1741983363; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J2tSiVPf+BUW0F9AkladILOereuKR/UKA5t851tNOaU=;
        b=lm9/pMOV4wWwjZ6YVMovaGxCyxFQWfuEyksFWtwxV9uVEHFLTPxajOo3ubekiMVtAF
         qWp8gNwkKkvZMNolMN7M3f9L/7u8wjV3Wb7EaYp2aKPxODNq6qT+KeIYAKyTc2a14sdS
         o6j6jIKTQhvbJjMtL8Q3YXSeUL/Th3YodUhdZay+qE8UzVh57InxgZ6A0WfrTfGJWECG
         KnMqhy3tfVcW1/jga8Cm48O5K1IdHsykOK4nCswCWgvp3uoQ5yzOh1BlM71oP4Tyy0Xa
         MV0gu7gC3gFGWqdVCzC3IQyEmA7xSSc4b/wJcFmjOGSwsEP1e2Ip/GVyfro3ix9Dbdvn
         JUPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741378563; x=1741983363;
        h=content-transfer-encoding:mime-version:user-agent:reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J2tSiVPf+BUW0F9AkladILOereuKR/UKA5t851tNOaU=;
        b=X4geCbybRzlCAuu3gaYFNsAWbSwIy84dRqacJHmKv95Hzj6M4gv8DM6Y9XHeALul31
         WsVZqEn+hzhIAJ06Sb4pU0QfO00sSWdUodqANca27NrIVc195NKX/njRcpXvc9JzCbbm
         PB/p5p69q1ajx+GnGRVCw5/PLfNe2z+f4A8sOMqUT6G5H3fJaCbToOtetHEznc7gVhcQ
         ugysr9V+5JksBJTKX2crjmcH+E7C/hiFBSN1jxpEW98IRqRFj7kgissE9rbmbd4vHGVO
         E15ECbP75dlPhkChA6rpNEu+GFQghHev2pwG6kiIdhF5OebDsC4YCuR8nq+z+sxLCBs/
         5dxQ==
X-Gm-Message-State: AOJu0YzlfJMbjj+bE+aXnW5cKBBfMrHg6VAxHwexa41Pk+ZmpzUmurRZ
	2Gk87u9taTTh1NTDLbwx9kiP9mgIXrNPnzy6FLp/p87KzKmulwcUa/f5iA==
X-Gm-Gg: ASbGncsh9TBbJzzk5n5wcDqwe/XTgvbw7tyb5tHMUep9S+LUMZAsmUz18oyn0BYaGPa
	0SWsO4SV4wikzLncKzbl7uWVa7feGW+8w3xx0B3UOFBOz4EOcrdY7QQ1P4T6eRGWXxPVqNVhOHE
	UIhj9R+QxA+i4QgbRAanSsJZ4ByMhdQe66VibZKYcIy3tMh5ulWmPVnx/fgqAP5X3Astg24Qx9n
	9WD7yn54fhajVkQzQ2dxxtaGELcmlpDxYzio9jCdkNIXW03IpX+MrGC3ZUV4VTWnqVMWpXL8SVc
	ywg9IQGxgiqk2QBd3+eFsmEtpJbj0cQatD+IxNjYL5dfiRdfjopDg4jW7cs4KSLuWhr32Diz8yM
	3yp1kYPmVPzB7Md74nCo=
X-Google-Smtp-Source: AGHT+IH1WNaxpfzqkR+MshpzZbsLkdubbWb5w3GJl3kgaDCGH78qZ8CxUIhzyfTH64dOxenmeY1phQ==
X-Received: by 2002:a05:600c:1c1e:b0:43b:c468:49df with SMTP id 5b1f17b1804b1-43c5a5e99ccmr33890895e9.2.1741378562819;
        Fri, 07 Mar 2025 12:16:02 -0800 (PST)
Received: from ?IPv6:2a02:168:8763:10:45cf:6e6b:4006:d873? ([2a02:168:8763:10:45cf:6e6b:4006:d873])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912c10437dsm6471996f8f.99.2025.03.07.12.16.00
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Mar 2025 12:16:01 -0800 (PST)
From: "Florian Franzeck" <fmfranzeck@gmail.com>
To: linux-btrfs@vger.kernel.org
Subject: Corrupted Filesystem after using btrfstune --convert-to-block-group-tree
Date: Fri, 07 Mar 2025 20:16:03 +0000
Message-Id: <emb7bb01e5-f3a4-416d-bbbf-cb9ad213c52d@5b4d3bef.com>
Reply-To: "Florian Franzeck" <fmfranzeck@gmail.com>
User-Agent: eM_Client/10.0.3530.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable

Dear developers,

as the mount time on my HDD was very slow, i tried

btrfstune --convert-to-block-group-tree


since then, my filesystem is unmountable and i wonder if there is a way=20
to recover without using backups.

dmesg:
[ 1169.017506] BTRFS: device label data_8TB devid 1 transid 358015=20
/dev/sdb scanned by mount (1603)
[ 1169.019015] BTRFS info (device sdb): first mount of filesystem=20
2c87b433-6301-47b9-84e1-5dfb49686c0c
[ 1169.019049] BTRFS info (device sdb): using crc32c (crc32c-intel)=20
checksum algorithm
[ 1169.019063] BTRFS info (device sdb): using free-space-tree
[ 1169.045544] BTRFS error (device sdb): parent transid verify failed on=20
logical 65028096 mirror 1 wanted 358014 found 358193
[ 1169.045868] BTRFS error (device sdb): parent transid verify failed on=20
logical 65028096 mirror 2 wanted 358014 found 358193
[ 1169.046019] BTRFS error (device sdb): failed to read block groups: -5
[ 1169.047648] BTRFS error (device sdb): open_ctree failed

uname -a
Linux banana 6.8.0-55-generic #57-Ubuntu SMP PREEMPT_DYNAMIC Wed Feb 12=20
23:42:21 UTC 2025 x86_64 x86_64 x86_64 GNU/Linux

btrfs-progs v6.6.3

btrfs fi show
Label: 'data_8TB'  uuid: 2c87b433-6301-47b9-84e1-5dfb49686c0c
         Total devices 1 FS bytes used 2.81TiB
         devid    1 size 7.28TiB used 4.48TiB path /dev/sdb


Best regards,

Florian


