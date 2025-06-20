Return-Path: <linux-btrfs+bounces-14813-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B1BDAAE1A94
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Jun 2025 14:09:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54BD74A6742
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Jun 2025 12:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3391B28A40F;
	Fri, 20 Jun 2025 12:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Jbwv5b78"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C4328A400
	for <linux-btrfs@vger.kernel.org>; Fri, 20 Jun 2025 12:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750421392; cv=none; b=O7CTXVJuYreRm6F5u091OIbn/7gZukETHuTERxetnqJMBh664e+GyDr3YTgh5r99cxFxUz37SKttJUBGMry1olhsSM3Iwj3aFNDwg9dB/O22LnunG0yhKZwe3OHRYFPj/atHrjpg9wg7t8JCI3ipS5qq0X26JEYq9RAJj9pmbSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750421392; c=relaxed/simple;
	bh=c4ttkA5lmffN+32M4fxq6N1nx5ih5J2uCTXEoBBRhQY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=c2gL2OL6FF6UyOswxlYMR7NoxdLexHcRQWiGZfFs0altTkUl1/c0W7IHyjCMBogXvR73XRJTlCiMucuf8meOaYRKcjtBbpQrpCboqB3S+aQX0FzSgd6QA59BpToESNga7luOMejmKOMNYuw5GGatznDcH87J6xEAm5H54bHLyPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Jbwv5b78; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-450ce3a2dd5so16545965e9.3
        for <linux-btrfs@vger.kernel.org>; Fri, 20 Jun 2025 05:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1750421388; x=1751026188; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=aoFpRnLAzMijZIUgSiwFKVzvI1avk3stXk6JH4QklpQ=;
        b=Jbwv5b78Wy1iSj4gjTDIh4VSWt3cfKWCRiwhzNg+fkZ3oboVKYx1OpYgsVxkAzLmx1
         qbAOJaxJSF88UyF6AaaAcE9fJ82rFsYiQ8989xQVRHbTBpwK99gN2F1tQ9XtMAtWCUYs
         EFvQx9LzGp2SF+lEx9IY0fgJ16g32CCDOX8QJI+J5f7kgpU8p5BdemomEemBWl5kjmU5
         qpXL/ajhxNWgGMVCLXRT3uDHlfj2aivE46j9QA2ZqMtebGRPJQjcyXdzFZMrDz3yvt8z
         ZZeK+AiE82wLk6ZOQtd7ZJxpUvXS10k3REObZDiRQ/Dv+3do1bVFEYAfpCXOarrGC1x0
         8nYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750421388; x=1751026188;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aoFpRnLAzMijZIUgSiwFKVzvI1avk3stXk6JH4QklpQ=;
        b=W5428QGCeq98RC4VRhC8VKqrMj/bE7WfkRHgwVi9e34cckEwGcIjqcI1ctSDwu7J4/
         k6O/SRfmPxYDAZ676YOTxlP/aptaU/JWumQgDzkXQJhDQ175q38u1iHRbNpFGhJ9sGZR
         dIZNju5HLpR3tJhcW3KYjlfqKCPKNzfLgZulKT0fxyhvEdqLrOjWWBwQMpkbxySa7XK7
         wRnPxOm8dm2zgdQUl2yWNeZ5EZGZ8goSJXEP91+TYMRP3fK7Yk9Z3ormA0TfcKjC9RB8
         BPVo40vVrLHEJ3LmsfAidKWnLkeYKcOdO7w86GQY9eNLtvBGy+nxrURVYUoj+fIKfD6s
         XrBA==
X-Gm-Message-State: AOJu0YzKV3Oa9ciqF5+P8Gvb1TAD8AlliVlMiex0VIQGrbeVAGeE/1q6
	LO34n4t+dRwah0RRzLOtw+M13zN9Epbak7Wd1y98Wu53pk7Im7DP8STBhmqUdEmXnUWproORBZr
	hpV0gzqr4gQ==
X-Gm-Gg: ASbGncsyCkrWKUkpXlz/pLr9xjxvFQ1moxgxGAneUj7Ss+6rKyYyIH9MClyHyuVSVrX
	vduqR/fFMGECB4WZMnnhJjVnD1/3QPfWU8dXsNLtLeSY77/ElMGvi9spqCsaTljhzSUNWVEWJnn
	lHPy45PZbdJu1MQOgSDE+TXe3MKx1Q2t0AL8h9ar+T2YkpGZ8da3DelX2TRi3iiYlynfKvlHFme
	BUuvmmA+j+xuGGgQKIoH6rcaRLxH0XucsVRj7RJF5rPSEztG6KQVj3w/nFYflkvgrzIaSUZPnG2
	9Qncrm3nhRs9/9w6jq8GpjbfJA79rwV984S2KUJ7UTk2WXrW4+wNp4iapVPviFghDM9i4Vl6PfI
	HgtTze0D5Q/qkaw==
X-Google-Smtp-Source: AGHT+IE/Asco5W/QWmU3j6V7i1FjgBNo/T4BMBtPxetAUfywBKthurbUdMU2h/M8FJBHvUw3S/5qOw==
X-Received: by 2002:a05:600c:1f0e:b0:43d:2230:300f with SMTP id 5b1f17b1804b1-453653925d3mr25463375e9.0.1750421388116;
        Fri, 20 Jun 2025 05:09:48 -0700 (PDT)
Received: from [192.168.3.33] (25.37.160.45.gramnet.com.br. [45.160.37.25])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4535a14221csm55331025e9.1.2025.06.20.05.09.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jun 2025 05:09:47 -0700 (PDT)
Message-ID: <0be69f379a9a7a3cb4cc6d1f5fdeae2172095b8c.camel@suse.com>
Subject: Re: [PATCH] btrfs-progs: filesystems: Check DATA profile before
 creating swapfile
From: Marcos Paulo de Souza <mpdesouza@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: wqu@suse.com, dsterba@suse.com
Date: Fri, 20 Jun 2025 09:09:44 -0300
In-Reply-To: <20250606150826.119456-1-mpdesouza@suse.com>
References: <20250606150826.119456-1-mpdesouza@suse.com>
Autocrypt: addr=mpdesouza@suse.com; prefer-encrypt=mutual;
 keydata=mDMEZ/0YqhYJKwYBBAHaRw8BAQdA4JZz0FED+JD5eKlhkNyjDrp6lAGmgR3LPTduPYGPT
 Km0Kk1hcmNvcyBQYXVsbyBkZSBTb3V6YSA8bXBkZXNvdXphQHN1c2UuY29tPoiTBBMWCgA7FiEE2g
 gC66iLbhUsCBoBemssEuRpLLUFAmf9GKoCGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 QemssEuRpLLWGxwD/S1I0bjp462FlKb81DikrOfWbeJ0FOJP44eRzmn20HmEBALBZIMrfIH2dJ5eM
 GO8seNG8sYiP6JfRjl7Hyqca6YsE
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-06-06 at 12:08 -0300, Marcos Paulo de Souza wrote:
> Link: https://github.com/kdave/btrfs-progs/issues/840
> Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
> ---
>=20
> I'm not sure if it would be better to just add a new helper method to
> check
> for profiles, please let me know if you would like to have a helper
> instead.
>=20
>=20

gentle ping :)

> =C2=A0cmds/filesystem.c | 11 ++++++++++-
> =C2=A01 file changed, 10 insertions(+), 1 deletion(-)
>=20
> diff --git a/cmds/filesystem.c b/cmds/filesystem.c
> index 64373532..21ff4d7a 100644
> --- a/cmds/filesystem.c
> +++ b/cmds/filesystem.c
> @@ -1718,12 +1718,21 @@ static int cmd_filesystem_mkswapfile(const
> struct cmd_struct *cmd, int argc, cha
> =C2=A0		return 1;
> =C2=A0
> =C2=A0	fname =3D argv[optind];
> -	pr_verbose(LOG_INFO, "create file %s with mode 0600\n",
> fname);
> =C2=A0	fd =3D open(fname, O_RDWR | O_CREAT | O_EXCL, 0600);
> =C2=A0	if (fd < 0) {
> =C2=A0		error("cannot create new swapfile: %m");
> =C2=A0		return 1;
> =C2=A0	}
> +
> +	ret =3D sysfs_open_fsid_file(fd,
> "allocation/data/single/total_bytes");
> +	if (ret < 0) {
> +		error("swapfile isn't supported on a filesystem with
> DATA profile different from single");
> +		ret =3D 1;
> +		goto out;
> +	}
> +
> +	pr_verbose(LOG_INFO, "create file %s with mode 0600\n",
> fname);
> +
> =C2=A0	ret =3D ftruncate(fd, 0);
> =C2=A0	if (ret < 0) {
> =C2=A0		error("cannot truncate file: %m");

