Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0C1929219E
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Oct 2020 06:15:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbgJSEPP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 19 Oct 2020 00:15:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725800AbgJSEPP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 19 Oct 2020 00:15:15 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70B76C061755
        for <linux-btrfs@vger.kernel.org>; Sun, 18 Oct 2020 21:15:13 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id f21so8912331wml.3
        for <linux-btrfs@vger.kernel.org>; Sun, 18 Oct 2020 21:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=RyCXbZDcO+dmTYrCW1VN0aXqiHFtSNr4M1COmU4dDf8=;
        b=g5j8k6cj2pB5m+yU97xZXIgxXkMrBIcVDkI9T5XFZun5Uasp4UCTf1JM+JNA8LZPNw
         wNtH9Jv71RhvWH5WHJccG3qPGcrtDmt1w7w2NZ4znxjMpPg0xdG9jyyK7lzKIYzuvsIq
         VALL1ua/ecVgTuIHWEgit11sMzVn5QiQRe5BZFnxHrYeu51ltxsjfzt0v1hwazN+5mQA
         ivkviJ3pLfuG1tD9OY0W1X/ztnSX0YanykiGL72N/3rEaZoM9JHK8DbEOk6ut6+XRR19
         qVRihehRBz3TrKCQdFT3CbQT2wMurPrLAVK3muavkPH7zhJVf0Ax1f1HFCcerq5lSsWw
         zRGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=RyCXbZDcO+dmTYrCW1VN0aXqiHFtSNr4M1COmU4dDf8=;
        b=QZRTlMH6/zhZC8svoqGIontyLNbXucRuxZE5YBqZ8qEJoImgbur4bV1ZtLXXrPUNjI
         AsnDXZjVWJYD0CBubn9/csZO1jUwEWeEePypydfhPm69k/hA4dqMLEGZrBBOgEJ52z4d
         hpwXTJcCyZo01XfloRyeET6ufKA8PjPpwJhPIKwrxLj9V9AqH60wsHj55SFb12uyjM2+
         OCM25kQaVe1nBjdWSZxxmcB+tcmsD48CkoVPPhP91DcQbTf5jG1yJaUiUP9B3UkrEGID
         HsQ01UO2uwY8JlocKLQeRN63kV1d9WpWxKyOrQHyP/xRdI7gKrtAONgDfsfH4VLPSnvD
         NHDw==
X-Gm-Message-State: AOAM531wHmMRYF8SS/RP+pOMWyeBcOdEZTbFazN604Gdncv8zG6sYZmv
        rW/059U6ywveq+evhOi/FR9uxoBC2yKJCC20caSlcQ==
X-Google-Smtp-Source: ABdhPJy8GEUlD1EOGrtT8a+aEKpy1F2b136QlVQbmrGRvGfhmCxjbV/eI6K+1UKsa9BYgQIJ3R4+lnGrAVKrUo8UxOU=
X-Received: by 2002:a1c:5442:: with SMTP id p2mr1800827wmi.128.1603080909781;
 Sun, 18 Oct 2020 21:15:09 -0700 (PDT)
MIME-Version: 1.0
References: <91595165-FA0C-4BFB-BA8F-30BEAE6281A3@icloud.com>
 <fff0f71b-0db7-cbfc-5546-ea87f9bbf838@gmx.com> <C83FF9DC-77A2-4D21-A26A-4C2AE5255A20@icloud.com>
 <c992de06-0df7-4b68-2b39-d8e78332c53d@gmx.com> <33E2EE2B-38B5-49A3-AB9F-0D99886751C4@icloud.com>
 <CAJCQCtTjj7Q9D9uKQRPixC6MPKRbNw3xkf=xdF1yONcqR=FM6w@mail.gmail.com>
 <6BF631F4-3B9D-4332-AC42-2BCDE387322C@icloud.com> <CAJCQCtTvTH7XeA1F3nd011-X4vVUZJ15zRN2HK8cOL722oJ13A@mail.gmail.com>
 <DFA69BD3-6415-4342-B17D-2CFBF0BED53F@icloud.com>
In-Reply-To: <DFA69BD3-6415-4342-B17D-2CFBF0BED53F@icloud.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Sun, 18 Oct 2020 22:14:53 -0600
Message-ID: <CAJCQCtScPgWGyUPyHpNKj-+MpffWCspCZ2rsg4zEq96U8_Pj1A@mail.gmail.com>
Subject: Re: Drive won't mount, please help
To:     J J <j333111@icloud.com>
Cc:     Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Oct 13, 2020 at 2:28 PM J J <j333111@icloud.com> wrote:
>
> Thanks again Chris,
>
> Its btrfs-progs 4.7
>
> I spent an hour just trying to figure out how to update it, and still uns=
uccessful : (
>
> I=E2=80=99m running OMV 4, it=E2=80=99s debian.
>
> Sorry for such noob questions but can you tell me simplest way to update =
btrfs-progs?

I'm not sure about Debian. I'd ask your distribution where newer
packages are located.

An alternative is to use a live media from a distribution like Fedora
or Arch, which will have a current btrfs-progs. And just dd the image
to a USB stick and boot it.

I suggest the 2nd download link, which is Fedora 33 beta x64. It has
btrfs-progs 5.7 on it.
https://getfedora.org/en/workstation/download/

--=20
Chris Murphy
