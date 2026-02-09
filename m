Return-Path: <linux-btrfs+bounces-21524-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EE3yI9OkiWlU/wQAu9opvQ
	(envelope-from <linux-btrfs+bounces-21524-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Mon, 09 Feb 2026 10:11:47 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5105210D62F
	for <lists+linux-btrfs@lfdr.de>; Mon, 09 Feb 2026 10:11:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 34F6B3004C3C
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Feb 2026 09:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F6503446B9;
	Mon,  9 Feb 2026 09:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iJN7+B6q"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB6BA317712
	for <linux-btrfs@vger.kernel.org>; Mon,  9 Feb 2026 09:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770628300; cv=pass; b=XkpQ1Wnvw1H+xC+nf0FtZW/EUX6aBOeSQlEIeywEtEc0WZg+PZgl/fN7Wc3kppStJ9Bd4Dl6wJPN7+XVbzSHd6ogVLTBTlSyZx1VLwZD25wNYxNXn29lbBh3V5I96OshbrDIeHH8WgPcvWQnAhipE0y9zRp21jJ5y2618juHTJo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770628300; c=relaxed/simple;
	bh=JgH4F9Fp+brpzH0Qr303C9Lv8LVUjDh+jR8lblMQb80=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=MvkUuVQS/eijAmUcBnLPSunj8ochAR0hseq8Jtt6XHd4go2T4L4sP3tUSPTb9go0si0agZ2zsSgNjkk2RzYOvyPos2WTnv4By+PdQARJWjTmXN2o24u2puOqNmykrqH1b1PaaMOeJwX2dZi6egsKi+ey0HNbM1yPebW5OCiiS8g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iJN7+B6q; arc=pass smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-12336c0a8b6so1066654c88.1
        for <linux-btrfs@vger.kernel.org>; Mon, 09 Feb 2026 01:11:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770628300; cv=none;
        d=google.com; s=arc-20240605;
        b=ShAmMAFqpJ4aV6CrVaj3Wl0z2fLUHi3ooYwUtLCCIyNxEA8fDy/eUMpT2eY3W+JSLg
         0AlwbVMVK+MMuFuo/pHvy0KHthHu+j6QfxnUiNns7sFZkdsI0fn16DGeqTjTQYxM6ICG
         LThK6On8PbHJ8uZZZX3EWNKcadNKnUbbddf9GScH04nI3xRRkj5Zc9BSHDAhboDAsw1E
         zA9DH82XdBOTKELcxgILstn9CU6vVcuOkMn1rS5LytQxiCmhlfT0CbLceOtioxK3iAxL
         p7LQjlKZy4BcBSSzSZq6So9vY0kRjP5bCxbr/rVL3qJPhCMfsTZgAVJC4f9mdmzT9AeW
         PLJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=JgH4F9Fp+brpzH0Qr303C9Lv8LVUjDh+jR8lblMQb80=;
        fh=IOI3BSFtc4S+mY5yRaEOyEQVEbaexZFmwOG7FNW1hpE=;
        b=fJAtyjTtFEsTx6ixmDa6Ds2zuaTBAJwM1sdBTVXvzbQw+faCTWs+lNU3mewKKohUU+
         qO0q9LZYnYXkX88VX50z1C4VSE0BpB7hq6bM6uDx2jDUA0QdjacMG05fixyIn6csgVQt
         dIYbEeYpe8+2/WxYLojSZ4GHgrjdPRM6WDHZwv95dKrGlEwdhYTxZOVfrBz2UQ7wg0SD
         NpdJ0S32lO8FsI8BymVS1gvg009puk6q/kj7GrbdZ/RO5DYJM/GXiTu5nqKLSIX8a+UM
         /n3lrAgLNufOMEPKhELEWkfY2+Wu9hlcKvYrn7aEpWp89HAY15uihUYb0tuyTOK21UaR
         1c0A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770628300; x=1771233100; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JgH4F9Fp+brpzH0Qr303C9Lv8LVUjDh+jR8lblMQb80=;
        b=iJN7+B6qreym6YEdg61wsyIlCrtZK3FJo8/DTjgytE21v9YkK6lClWT3qQG/UiLvcE
         pxDVXFbQBzqo6NiNqc7H+1Zw82UtVKVYcNaPoZ28kX/ESUoat7Grq9tPnoch+QlsB9pY
         wwmb8lV5hMWYXAP4gkz1ADi4tOpQRC8pA8L+/EcZ9OocegDXn/2sSZ0fNwDWdgu2LHHN
         fAYlnG+QP8l4nbGsOU5m3aAUboREGQH0ncIlSwHVfVabxtxYO0G04rnD9t4i622MnYIa
         49utYyVN/6yrGe+xKHRaabqLD9cIfl9R+mskglSwX1KR/ZjmcBoOobVeocxZFjXJIRaG
         SRIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770628300; x=1771233100;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JgH4F9Fp+brpzH0Qr303C9Lv8LVUjDh+jR8lblMQb80=;
        b=Wxi85Mz3XNlXhxYGM689ykMPZ/YriXsu/9CrpoO1vbCFCYB6XwprNU1Q5R0mtZa+l8
         cpokEQeeA1B9lfxMM1SPoz4hd3uFxRNzNrORMs7iLujSREAw0WbyivDSrsVg6fqkPsX6
         B0gyhkrf+lDe/kPLRIxBjqGaYax5AUu6aKa2zYQIUTebd3i0b7BjYWg6/Mlzl+iPZ1St
         It8t1+qedyGA6wNkW3L7SwOKjX6khRFvgI92gNo5sK+s707YPEc6j17J0H78dWz7Urlc
         Wy+3oE3QuWymrKKfmeNHg/YNIFF2BjfRzU9DE2wT8qC3aLD6Hv1Wv526ynvl4bHscQZh
         HGrA==
X-Gm-Message-State: AOJu0Yzj1DoJRvbe26enxEnxgQpwSBmuSV0qyodjELTrHl+qpN2Zq2yH
	/nkld9Fni6O0fFlJ3ADEHgPunX69jnW9o4fUcwuH8FUk9izAgfn8QINzEGut+nakIVx/iWOLR6N
	6SfxEdVr1SSleU6gX7tokhc0N7FISjoPiksrk0w0=
X-Gm-Gg: AZuq6aK1g0GmQAv314/b3iSXlz81nIopiLj8OPVZ7SQvyiQZdNCr/tJyDwHkXfjlwjw
	M/xnuVMd/vZ01uhjyW9A/iy/+xpSjxwYBah61Qz6pYD50/Z/bpRKpMYk8QCMVURYQRD0HZrR4Mv
	h+DqaWWg6i6iBm9gQfI2vQCFyi9Q+rdr4Y6IwE6t3rJqPJoxw1ZjlgDX2cj7i0NItHPn654/FJe
	jncaz8AcT6/MlOhEfhSkrgVAN/Wit8yD+1onMrLwg7GT/JM9D9EU00+nVyI0AE1t/hUeuPw2hlv
	Xb/ObxL7Mk+2mUJOb/ELXjNE/sj9SL9CtMdIol8tumVY76oAeWkLKZi8
X-Received: by 2002:a05:7300:aca6:b0:2b7:20c6:36dc with SMTP id
 5a478bee46e88-2b85670ff1dmr5015347eec.42.1770628299561; Mon, 09 Feb 2026
 01:11:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Wladi <wladik.haha.psn@gmail.com>
Date: Mon, 9 Feb 2026 10:11:30 +0100
X-Gm-Features: AZwV_QiQ2Vf57gcM3iIPaJ6A8aOdhDEuy01X9ejX5MOkO1t8DcwWawJm80zw9fw
Message-ID: <CAGpq3yLOFSSn3knMWLOCu39DnJeKPbSGZZky6KfPJEo=+U5p4A@mail.gmail.com>
Subject: Kernel 6.18, 6.19 very slow write speed compared to 6.12
To: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21524-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[gmail.com:+];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_ONE(0.00)[1];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wladikhahapsn@gmail.com,linux-btrfs@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	NEURAL_HAM(-0.00)[-0.971];
	TAGGED_RCPT(0.00)[linux-btrfs];
	FORGED_SENDER_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: 5105210D62F
X-Rspamd-Action: no action

Hello,

(If this isn't the correct place to ask this, I'm sorry)

My system:
WD SN850x 2 TB (PCIE 4.0 x4)
BTRFS + Luks2 (4096 sector size)
Ryzen 7 5800X3D on B550
Fresh installation, drive only 5% full

I have noticed that my write speeds are very slow with Kernel 6.18 and
6.19 (on both linux-cachyos and linux-arch) compared to 6.12 LTS

I've tested with "KDiskmark" (Fio):
SEQ1M Q8T1 with cow
6.18 and 6.19 -> Read 6900MB/s, write 900MB/s
6.12 -> Read 6600MB/s, write 4500MB/s

With no_cow write speeds reach around 6000MB/s on 6.18 and 6.19

Is this a known regression?

