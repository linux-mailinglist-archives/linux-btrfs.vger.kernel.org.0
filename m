Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 38844AE195
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Sep 2019 02:00:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729108AbfIJAA0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 9 Sep 2019 20:00:26 -0400
Received: from mail-wr1-f46.google.com ([209.85.221.46]:43311 "EHLO
        mail-wr1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728358AbfIJAA0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 9 Sep 2019 20:00:26 -0400
Received: by mail-wr1-f46.google.com with SMTP id q17so11762642wrx.10
        for <linux-btrfs@vger.kernel.org>; Mon, 09 Sep 2019 17:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=N41kjxbfjVnRwW+CI7pQ2ZEiPQfXgzWC7nBPjYgXWts=;
        b=e7JbLYshhPQHQmQ1u43KjplxJsQ02Uf4mhhmWA1jFFP7BQUyz5ReZS3NE7M9Pv/YJg
         Sgna2j10BFczIn7E+ws3sQ1FxPhOYfH3aW/YB+vzvOtAI2FUOBrn8bdqEP5UQDDKcaSf
         tIDOoCV1zm2jt4HFgFo6bcVv/0q4sb2Nr823gFSDtdq7qvZ1ZUbQlFesgy+fXuCpbUIL
         SpqPqTp4JZb6d64h1J3UV1KNJoqF35EzGz+4qhniMN68pytBA+hgQSvO1QTyo2WBag7s
         hKxsSLthHa8KuubuIxIssZhiz26hV1tsXCHhpePbX4PgVkWocddBHMANmoz01t+VLxI4
         g4/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=N41kjxbfjVnRwW+CI7pQ2ZEiPQfXgzWC7nBPjYgXWts=;
        b=d1h082cBfF3s2gF0Db4YaoYcDnoaCVJLme0x+p5FyCLdJItwqVtQFj/iS3Q9mp6zE1
         JKAfa2DdXconz0Rwvruzc4mycvHBRCmyird2bE4Pd6KdqQudhnl6DdOqY+3zqyL94CbY
         WgKoSaqR0z/VbI3F4LEP2RV4bF9tngl5rCy0tUqksGC7uhNIHHmQS7/LR0LE5Qf8A7p2
         I+b7aIJoERMMWSTO9cy1v0njv49K4SS9hPeXTFIZKy1TPWWHK98lFjrdQHyu8Qepa4zX
         jA9m5DxeYEnYJrw3ijsOwoX4zCaJ+9P0Zg4czwaaWnCH7Rbxb5BFBozTMmsybxifb9LC
         NrOA==
X-Gm-Message-State: APjAAAV50JOw23TNPyuVOl9CvCPMOSXC7dK7NN9XkIYOwaUw0lb1MDOE
        hQtIrHEmh5Wa+QWLjFDxhtOL/5ThAdyKt8ZWJugVkJ+fhN4=
X-Google-Smtp-Source: APXvYqxGFhSCD4a9Vaqido6JA0mL5w3aHJGa1hPp3nQQpG1jZyZZjaPvl3MEe45ZxQZBZORCowBn7dxEicJybgP3+hs=
X-Received: by 2002:a5d:54cd:: with SMTP id x13mr21579695wrv.12.1568073624279;
 Mon, 09 Sep 2019 17:00:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190908225508.Horde.51Idygc4ykmhqRn316eLdRO@server53.web-hosting.com>
 <5e6a9092-b9f9-58d2-d638-9e165d398747@gmx.com> <20190909072518.Horde.c4SobsfDkO6FUtKo3e_kKu0@server53.web-hosting.com>
 <fb80b97a-9bcd-5d13-0026-63e11e1a06b5@gmx.com> <20190909123818.Horde.dbl-yi_cNi8aKDaW_QYXVij@server53.web-hosting.com>
 <ba5f9d6c-aa6c-c9b2-76d2-3ca56606fcc5@gmx.com>
In-Reply-To: <ba5f9d6c-aa6c-c9b2-76d2-3ca56606fcc5@gmx.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Mon, 9 Sep 2019 18:00:12 -0600
Message-ID: <CAJCQCtQD5tCrFO+M8=R0jksqE4eXsshzy53smKXKRqgiRxz2zg@mail.gmail.com>
Subject: Re: Feature requests: online backup - defrag - change RAID level
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     webmaster@zedlx.com, Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Sep 9, 2019 at 5:44 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>
>
>
> On 2019/9/10 =E4=B8=8A=E5=8D=8812:38, webmaster@zedlx.com wrote:
> > Yes, it is true, but what you are posting so far are all 'red
> > herring'-type arguments. It's just some irrelevant concerns, and you
> > just got me explaining thinks like I would to a little baby. I don't
> > know whether I stumbled on some rookie member of btrfs project, or you
> > are just lazy and you don't want to think or consider my proposals.
>
> Go check my name in git log.
>

Hey Qu, how do I join this rookie club? :-D

--=20
Chris Murphy
