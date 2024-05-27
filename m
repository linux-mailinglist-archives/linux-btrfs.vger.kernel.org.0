Return-Path: <linux-btrfs+bounces-5300-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82EA58D0230
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 May 2024 15:51:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56B3D28402F
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 May 2024 13:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5326815ECF9;
	Mon, 27 May 2024 13:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="CEWDhMIg"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA4CC15ECEC
	for <linux-btrfs@vger.kernel.org>; Mon, 27 May 2024 13:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716817872; cv=none; b=a2JabmdG1LqO2qhQyIuZeBXmmx3IbSpKBT+kgRHKE657YS31WQY65JPwN2XJ4e/IDd6QkVH3TYtrixTQ+tfxqckdHtuZ0Uw+3NMwzrexGum707JoN7dF8bL5/c7jybqqHEtuHO6d3iPU7jq5f5Ki65Sg8XM9KB+ZmgpoZYbYJsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716817872; c=relaxed/simple;
	bh=uuQY43wa+0cys4WzKZsdo95EDIza7dv83nymBpPfuio=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dSTo/abiVlsetYKrU7jqRlOAx4HvhakhHoAxVjjW+mxq5Sqsb3zfukHtThvUbwJJmGkMp9C2Z0pg2fr+epPKDWUl9Gi6+pMafnVwm9iTT1txmGUWe3k3Oyg2g0WMmnsMDAiXPQUXgsqmh3hGnF3sCiuE3a4mSXAuc8BGzPrwX8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=CEWDhMIg; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a62614b9ae1so431350366b.0
        for <linux-btrfs@vger.kernel.org>; Mon, 27 May 2024 06:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1716817869; x=1717422669; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uuQY43wa+0cys4WzKZsdo95EDIza7dv83nymBpPfuio=;
        b=CEWDhMIgwS6jcTyM9CnO7Rs5RJSfU/Ovrj3b06MqDJ6R0YIYvhzNBppzLFJqGSdNmy
         XiTjn+ECfLvvID5/oJgG0etMRFTl4BEZEDxCCZ8SNhtcOx3apaD8OEhdO5DZaGW065Do
         cZdNLeGeLioeciz/B5oH3VdXomvPXOPafXkds=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716817869; x=1717422669;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uuQY43wa+0cys4WzKZsdo95EDIza7dv83nymBpPfuio=;
        b=eHG/TBhoezJRV0gD3z75UWwzggrvQgru8s4jI6RAje57yBIghvgxfyzSjnrW3N74IW
         jK9Q4FfyfN5TOAC/1J2oX7zRylUN+n5Bxd0GGQfA3c3arMHKyWEvCTJMqmVlj9uj1cCW
         3CYlcz5YvalWueNpTChs9D9yWiC2OVqoDePCNdZhOd+/JbfR2oW+umDHlsHnx6FpmQzx
         oUt2i0vIwMxpTrBtps/4to5o2W45WAfeTOSD92rLAkPVxlGod77YpnSS62CmimteGOT9
         JpxBfwlIBL0w+Z8nH27J3BrNsmipd8A/2zLD9fIq7AB9f8+CTmt/WXKSc7vWq5RWlafG
         a2vQ==
X-Forwarded-Encrypted: i=1; AJvYcCX+/QLASWWnWDKWhbSPxL7IQt5aE+0mbbowqubRAWgfHPeToa41ffaiZ91y2d5X25aYudrm/n8KjEZ6bB2B2WkAjVh5puF7C8kqU7w=
X-Gm-Message-State: AOJu0YySr3y7x93vhMcLcm3uoF+C0TRB3N41H2ShdKxP1d8mSo9CE2rH
	vNccabsdLN58J/Izb4Qs+L9r07+3CTt5jbKVEwgnVHHfP7kYYVBKxAaUJ6FF1mgryZOQZImdoTw
	LTe+xsYIUjpCrT7xM/7RoFtbcFjrBMulGvendwg==
X-Google-Smtp-Source: AGHT+IE+776/I97VJo1iquiMi/Yw2Zf4q5ChRdOsvC6Wn8oeSttS7ENd+orAmozSW0Y0YeHPwc8Ri+zGLINvPPdC46g=
X-Received: by 2002:a17:906:5a70:b0:a5a:1562:5187 with SMTP id
 a640c23a62f3a-a626512942fmr636424766b.55.1716817868894; Mon, 27 May 2024
 06:51:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <000000000000f6865106191c3e58@google.com>
In-Reply-To: <000000000000f6865106191c3e58@google.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 27 May 2024 15:50:57 +0200
Message-ID: <CAJfpeguD5jSUd=fLaAGzuYU-01cKjSij6UbQWy72LDpqK1KQfw@mail.gmail.com>
Subject: Re: [syzbot] [btrfs?] [overlayfs?] possible deadlock in ovl_copy_up_flags
To: syzbot <syzbot+85e58cdf5b3136471d4b@syzkaller.appspotmail.com>
Cc: amir73il@gmail.com, brauner@kernel.org, clm@fb.com, dsterba@suse.com, 
	jack@suse.cz, josef@toxicpanda.com, linux-btrfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-unionfs@vger.kernel.org, mszeredi@redhat.com, 
	syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/overlayfs/vfs.git
 f74ee925761ead1a07a5e42e1cb1f2d59ab75b8c

