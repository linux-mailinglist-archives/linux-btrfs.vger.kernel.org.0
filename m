Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88F782002B4
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Jun 2020 09:28:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729987AbgFSH2M (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 19 Jun 2020 03:28:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729548AbgFSH2L (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 19 Jun 2020 03:28:11 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D8F5C06174E
        for <linux-btrfs@vger.kernel.org>; Fri, 19 Jun 2020 00:28:11 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id m21so6756063eds.13
        for <linux-btrfs@vger.kernel.org>; Fri, 19 Jun 2020 00:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=AVJmeEsepVVU0N5YqPQXMBcCCWtXoh6qX+dFOUXCN+c=;
        b=rSxgw1WTPAxpjnWE+z6yihPCydfxBIo8nSztaQRLlJ4psA4anea/4PzBVuJ6Z5SEi/
         G7mOz3SP67lDUD+gWBSQlyWgtaThH3TGhbX02J/tO5MEkvFo08AQK8JgdKLTFkTjxtOE
         ViPukV8ziv+D34qy3fdToVGsZ0bpGrRsYbgIThECIKfMd66WMBvO7ZdVlNrPb95uHDi8
         8WSzlAygXnxmYzZ3wCkT/T5OJREXIAKt6kiskrlX8usDrQFHIhOhIZ/5A8EqdpW69gfP
         hT5maQuij+gq0gIhsVE1TdUF5XMvRp0fg5JpErF/eS0guKDoT0kVidB+U1y18iyakVFK
         /fpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=AVJmeEsepVVU0N5YqPQXMBcCCWtXoh6qX+dFOUXCN+c=;
        b=DffbzPiIBkis/sHWdg/W+hqjGiGpM7Yur7C8ZzAdDSJZNwGRFDTyiRr2P8YTALDmjP
         c9/qq+8tULFzorkDLpt6O0UxlWaCxorT4WY7v4/PMsAp/UQ6xpXaWk37u8IuABDysCdC
         Af6TT6B/QJ4DLyEEih5Eip7QbWQP78RgHe3o4FonjIqtiGiV+pHpEgj/pXm1Ryv6t9WK
         QTTaXWDJmZ+eP0domIH7ySa41IC0NlZMMIskYNiCceLxs/7JB7b5jeR0hzTUHeMNypJF
         hP6ylPmfmDZe+Br5NWugHA19l/Oh9Vf/wPKWIaOesv85uSP7te8eSeU4RwrhkCUEYpct
         7AvA==
X-Gm-Message-State: AOAM532J/Vjq6MpRrSIrMVikG/Cse/fjo+tYGQvyhRlxIZgI0fdRZBe/
        9IxgevrzT8gqmgFxyXpHTplPCmXMFvNenVWtTGEtEOum
X-Google-Smtp-Source: ABdhPJw0EcN+L7iJoEnl9atLo43E6zVD+XSuZXmon1yal2T6vevczY1HkhLmln0BOewrWCCQZ+rS1O3f7m0trM/rmH4=
X-Received: by 2002:aa7:c682:: with SMTP id n2mr1909531edq.18.1592551689151;
 Fri, 19 Jun 2020 00:28:09 -0700 (PDT)
MIME-Version: 1.0
References: <CAHnuAezOHbwpuVM6=bJRRtORpdHy=rVPFD+jeAQVz3xUTEsUpQ@mail.gmail.com>
In-Reply-To: <CAHnuAezOHbwpuVM6=bJRRtORpdHy=rVPFD+jeAQVz3xUTEsUpQ@mail.gmail.com>
From:   Daniel Smedegaard Buus <danielbuus@gmail.com>
Date:   Fri, 19 Jun 2020 09:27:33 +0200
Message-ID: <CAHnuAew38EFYgig7Ui7jcOCg6uOKrdnqKmLoFAyBic0ttAnhpg@mail.gmail.com>
Subject: Re: Behavior after encountering bad block
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, 19 Jun 2020 at 09:24, Daniel Smedegaard Buus
<danielbuus@gmail.com> wrote:
> This seems ... well, wrong. Like, in, bug wrong. Surely, a single
> block of bad data on a device shouldn't cause btrfs to produce such a
> cascade of errors, making so much data inaccessible?
>

Oh, wait :D Wish my "cancel sending" timeout was longer on my email.
Just realized the bug; me not using notrunc when "rotting" my loopback
file. I essentially destroyed the entire loopback file from that
sector til the end XD. That explains everything.

Sorry for wasting your time :/
