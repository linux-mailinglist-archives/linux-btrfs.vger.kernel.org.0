Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4DC1E19E788
	for <lists+linux-btrfs@lfdr.de>; Sat,  4 Apr 2020 22:23:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726332AbgDDUXY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 4 Apr 2020 16:23:24 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:33798 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726327AbgDDUXY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 4 Apr 2020 16:23:24 -0400
Received: by mail-ua1-f65.google.com with SMTP id d23so4061495uak.1
        for <linux-btrfs@vger.kernel.org>; Sat, 04 Apr 2020 13:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=IQlnwUpu7bcCoRU/Tcm/g/KskqgYe+w4uaRSJmQ6UaY=;
        b=foC0iXMYEbQCCG6g89o6QTN2fjpqaktJEDuUKuGMX8nYS9KxM+t8uwREM491pCAXS8
         iUM9GSvc49UZXee6DbKa+UD43ZlefZE0LuqgQaAYYtcYsGDFXW1O2BJj4Zu4TQ7yeC65
         YfAC7yW2lJJy96I69GeBa0rVReTv1VV4jZv8n7IVo8G1dtrgyokt8B0BMw92LELWMPLQ
         PMJT0Ges5MLIoUEjcWYnJw86gkFhYxwalIDxZZkNshcPYPvSFtChXhBI+lS3xprd3e7t
         LiFuvxEE9hd/8R1v0oNunu2SxZEzDekrn/PhhJyr+ICwnWBgqivqmSdb+tJcUiT3NSki
         E3cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=IQlnwUpu7bcCoRU/Tcm/g/KskqgYe+w4uaRSJmQ6UaY=;
        b=XlgdchIZ81W7TKW3XSOwZp74FdUWt4cG9P2Bfmv9UcliwgQkiI2E4u9sF8kMxCXK38
         bnmfnnc35lejNuahikwLBkftm4o+XWS73YGZhE8b3z7XxndY1jdO8Vn/Z9s8swUA/XXV
         1UsXs73I3WtEJH3xJPqJwBBE9dSUecJ6cG1HDb7fkrM8SgyFq7SpVVilIRa1NhmWI+fm
         PqayQqA3RhjRniU+WwMTSUReiwM9noqQlTd33DPq3iTGmkxk43hgC0wwC6zhTT0ecH8i
         3eeoDX9gocdsJumXveBkPHb8FpLu/kWwtQVPpiaVSTEQtFAEbw2Gx82jOU7W32gcMbvk
         FRZQ==
X-Gm-Message-State: AGi0PuaPYoo4CXv/Hux8Y03riqZdJ0+w9eQsXvfKZVpUadgTGscfSO3m
        iD3YlxBiMpaziZD2dtMIQluut19I4pwEIleb3VBhFiEN
X-Google-Smtp-Source: APiQypLnTS4+S4S2wyyArIjN+hlN0PIr8Eik8P7E4qf20liYcNcGhM8ebRP2ZT1CEISfeFqQwq7XH8NV4nFEed3trV0=
X-Received: by 2002:ab0:45d3:: with SMTP id u77mr10888144uau.27.1586031802441;
 Sat, 04 Apr 2020 13:23:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200404193846.GA432065@latitude>
In-Reply-To: <20200404193846.GA432065@latitude>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Sat, 4 Apr 2020 21:23:11 +0100
Message-ID: <CAL3q7H4xya8EuBhGsX4gs8V6xdNWpJhjhJj0-KdUJhMnDjHjXQ@mail.gmail.com>
Subject: Re: unexpected truncated files
To:     Johannes Hirte <johannes.hirte@datenkhaos.de>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Apr 4, 2020 at 8:52 PM Johannes Hirte
<johannes.hirte@datenkhaos.de> wrote:
>
> While testing with the current 5.7 development kernel, I've encountered
> some strange behaviour. I'm using Gentoo linux, and during updating the
> system I got some unexpected errors. It looked like some files were
> missing. Some investigations showed me, that files from shortly
> installed packages were truncated to zero. So for example the config
> files for apache webserver were affected. I've reinstalled apache,
> verified that the config was ok and continued the system update with the
> next package. After this, the apache config files were truncated again.
> I've found several files from different packages that were affed too,
> but only text files (configs, cmake-files, headers). Files which were
> writen, are truncated by some other write operation to the filesystem.
>
> I'm not sure, if this is really caused by btrfs, but it's the most
> obvious candidate. After switching back to 5.6-kernel, the truncation
> stopped und I was able to (re-)install the packages without any trouble.
>
> Has anyone ideas what could cause this behaviour?

It's likely due to file cloning.

I found this out yesterday but hadn't sent a patch yet, was waiting
for monday morning.
I've just sent the patch to the list:
https://patchwork.kernel.org/patch/11474453/

Since you are only getting this with small files, it's likely the
cloning of inline extents causing it, due to some changes in 5.7 that
changed the file size update logic.

Can you try it?

Thanks.

>
> --
> Regards,
>   Johannes Hirte
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
