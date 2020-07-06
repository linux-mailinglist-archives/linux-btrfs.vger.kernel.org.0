Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 793DE2155C2
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Jul 2020 12:46:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728527AbgGFKqo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Jul 2020 06:46:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728521AbgGFKqo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 6 Jul 2020 06:46:44 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37DDDC061794
        for <linux-btrfs@vger.kernel.org>; Mon,  6 Jul 2020 03:46:44 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id f12so15620455eja.9
        for <linux-btrfs@vger.kernel.org>; Mon, 06 Jul 2020 03:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sjeH1GSbRCTJnXCfqyrgwMgIBnLTtK4DV64ZAMwFe6I=;
        b=YHeBjrj6hRA4kb8dDWxCplmbk6n2osFXRYOF3I1EJNphzbAuRj+1qxprHox9nuktos
         dLTCyF0KS6bn11tZdBmw7bLjKMo84SVMzuu5DcuDrFEk/6dJsUTKjzyAnIr7sSLnbxmd
         ugbISfIiYB/Rulg/0AUVwNtcE+CH1zmC9p/58qqjlsvPn7X0gnuVAYwn9X8+E72xMLcT
         wuX3P3Mi5umgkDFSytJkJL1DdZoNn8xHYjnU+AAs8Ck5BZXTEO2BXoWb/I4JZKQ6qBvN
         SErpOPcE/+vf5Ytv7GUKMWTuKy+bk2TDsRrgIWXlDoutQ+ArmIeHFCXwb7+eg4B03PW+
         n6Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sjeH1GSbRCTJnXCfqyrgwMgIBnLTtK4DV64ZAMwFe6I=;
        b=H/ZSkpS4C+i4Jtx4MH3OPzPeRer1oG3+aMlf8D9Z4aFfrxQr4x8q4tsDcNRThWIVgL
         tW+4g6MfwkxosQCcfb6njIBjJue7wmcKJtOejhWt3IIuvZJXbVjbzaTs+9U4JIsq2lvZ
         dH9EByuvCxqW52mGtQtUnMt9NGXW3oIVzWH0AVgY5G+0CtSSjbLIE3Lr0OTS1sGoNAZ4
         ljoeU0S2A71JeVAtKi0jNbvyID0+n9skphJ/YoeqOBOtx3PUGOHX4FSIbI5Wrb0tdU86
         hKzmLtrVYesh6iSZYOJ311YXQV/shYi40Hy4E9/QHWNC+uHJH74L+h0ePVbSwsxV72X9
         IP9g==
X-Gm-Message-State: AOAM532yQ+S9Ku7wFLlNOaTtnmxSLa1KyzUD9VmmQ3irBn2td8iaLHjd
        hrw8XnydBK0ij8TyKEMtShQci/uAFgAF3LD1Lk8=
X-Google-Smtp-Source: ABdhPJwxxbUnzBrBu67iwSChud04uVQIIeWFqDj6bC3e/OkWmMq/nhymKQobYdNujwCrIT1136PbUXBq1j0NgWEcxlo=
X-Received: by 2002:a17:906:1751:: with SMTP id d17mr26008824eje.140.1594032402947;
 Mon, 06 Jul 2020 03:46:42 -0700 (PDT)
MIME-Version: 1.0
References: <16bc2efa-8e88-319f-e90e-cf8536460860@gmail.com>
 <20200618204317.GM10769@hungrycats.org> <65eeb90a-e983-2ae8-14ad-79bcd2960851@gmail.com>
 <20200619050402.GN10769@hungrycats.org> <20200619131117.GD27795@twin.jikos.cz>
 <79672577-6189-10fe-b4bc-8cf45547b192@libero.it> <20200622224556.GP10769@hungrycats.org>
 <CAKuJGC_eDi3isqJHxn6XG8GerOthYeVTb1j5cTPYSiuV_oFgaA@mail.gmail.com> <20200703031611.GD10769@hungrycats.org>
In-Reply-To: <20200703031611.GD10769@hungrycats.org>
From:   "Lakshmipathi.G" <lakshmipathi.g@gmail.com>
Date:   Mon, 6 Jul 2020 16:16:05 +0530
Message-ID: <CAKuJGC8u7h1R2ojyuSjZzbGziQf+phZvMZGg9Vm+ER=RfTJe2A@mail.gmail.com>
Subject: Re: btrfs-dedupe broken and unsupported but in official wiki
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc:     kreijack@inwind.it, dsterba <dsterba@suse.cz>,
        DanglingPointer <danglingpointerexception@gmail.com>,
        btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi Zygo,

Thanks for the extensive details about the data-set and how the environment
is set up and tests are executed. I'll try to create some windows raw
disk images for testing and follow your test environment setup as
much as possible. Performance numbers are really interesting between
bees, duperemove and dduper!

As you mentioned previously, dduper is more like poc and I didn't spend
much time in testing with different data sets. Mostly created few GB files
with `dd urandom` and tested them. I guess that is why it performs better
with files that are entirely duplicate and small extents :-)

Let me spend some time investigating these issues, I'm pretty sure dduper
can be made a little bit more reliable that its current form.

Reg compressed file system tests, will check this after resolving
poor disk-space issues on non-compressed filesystems. thanks!

----
Cheers,
Lakshmipathi.G
http://www.giis.co.in https://www.webminal.org
