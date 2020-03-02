Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B6D7D1751D5
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Mar 2020 03:38:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726720AbgCBCic (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 1 Mar 2020 21:38:32 -0500
Received: from mail-io1-f53.google.com ([209.85.166.53]:42716 "EHLO
        mail-io1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726690AbgCBCic (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 1 Mar 2020 21:38:32 -0500
Received: by mail-io1-f53.google.com with SMTP id q128so1784021iof.9
        for <linux-btrfs@vger.kernel.org>; Sun, 01 Mar 2020 18:38:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E+4bafpZw//Ech8Z7N2f+fGI3ziuN5jTbYyVZMYZKqM=;
        b=iAi74zYJ3GnkcSeAaZimBWzIOmey61jqcEkStVK3RkHH+JKZlUk2NCcxw2ZHwJaTjp
         0MbofhUreykxRRLrSdKQb/y+kyqcqg9gqvs+E/JVzWKtR+biCLl2LQNrXmRL57ilRJ1+
         lxvdvTdn4IfAGJ8hB5fsr7tP3aTaa7quJyFOfBX6a8ZMRvj0F5t7nrgWKtjcUdRoO5nK
         /OBwu+TSbFwohkpXKTvucWgE1DHRFlAOzTANA6dhUF8gdsVD90UcRRq3vrMuojjmXGwt
         mNu3Z6RTeGjFofoxgJ50pOeZ2BdlxE9GJmYpBZ5SQumOF7RegLTidA+mumeQZAWWqXnv
         U2Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E+4bafpZw//Ech8Z7N2f+fGI3ziuN5jTbYyVZMYZKqM=;
        b=QihPru9GnTjXonkrOli5KIuDMqk7PDw+sXGj6KK0whTY0brFXgQTrbnuKVHlh6v7zi
         tclkodt9A5708deQm2ukWww+QWSbXx/OEGUtqlWypjeGU2qTdVJKbq6eGhhLnwvLnT6o
         C9lXj0YXoUWczmOMri0bB3gheARcIRBwR7EyKMXFgE5OMCsSFpvZoiQuJMSGwrzWVp55
         McIN2P3E81iA4V5z8YoI74khfmrz7YEMt5uFyTbcJ0T3seVPS5Oavag0GUb+TxGRS0Du
         cix4FX33/0hmQFCpyyMt9NCtw+GYRMHLR+f2K/6/4czz9ysGb2GetT0lNWDbnX5Y/el+
         LEqA==
X-Gm-Message-State: APjAAAXfPSiijQerpZhEjLYcry63IU+1udFlJmWQl92nGOkncrNrNn3/
        o/lPAfFKFpVhodZyE5oKZUgKGIWg8popjKlQ7YGIWbdt
X-Google-Smtp-Source: APXvYqylMzNXV/0IqKTXpFcj+2LkBlpQxqD2Em58F/Ct38qJ1wngIOkuFnumYIYZi5dvZEQRftw5m2KQtfk+RmgJGTQ=
X-Received: by 2002:a5d:970d:: with SMTP id h13mr11457110iol.279.1583116711489;
 Sun, 01 Mar 2020 18:38:31 -0800 (PST)
MIME-Version: 1.0
References: <CAG+QAKWwvevCz5zYDtkOO5V0AA7bJuoZWHJ2CZjc1ofsO-c7xQ@mail.gmail.com>
 <CAJCQCtQF8f0UsVuFU_TXxWJ2DZQcFZABTSwPu18ob7RcSUKW_A@mail.gmail.com>
 <CAG+QAKUzqdVf88G9ZdLKLa3YUQRcvJMS47qQkhLsgiQ46R19Bw@mail.gmail.com> <CAJCQCtQvEOX--M5pXN=2fSmfPDM2ADK3JhStTWiTdXTCV_XBXQ@mail.gmail.com>
In-Reply-To: <CAJCQCtQvEOX--M5pXN=2fSmfPDM2ADK3JhStTWiTdXTCV_XBXQ@mail.gmail.com>
From:   Rich Rauenzahn <rrauenza@gmail.com>
Date:   Sun, 1 Mar 2020 18:38:20 -0800
Message-ID: <CAG+QAKXf9JuRgUU1+shTmTNe=UZNQCLHqomUMiQm+zfqFak3tQ@mail.gmail.com>
Subject: Re: btrfs balance to add new drive taking ~60 hours, no progress?
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Mar 1, 2020 at 5:57 PM Chris Murphy <lists@colorremedies.com> wrote:
>  >But I still don't get why it wouldn't move blocks from the full drives...
>
> To where? There's only one drive with unallocated space.

...but that's what I'd expect the balance to do?  If Block (Chunk?) A
is on, say device 1 (4TB) and device 2 (2TB), why wouldn't it move
Block A to the new drive from device 1 or 2 in order to free up space
and balance/spread out usage across the drives?  Is that not what
balance's purpose is?   Or is free space required on 1 or 2 in order
to move the allocation to the new drive?

OH!  Just checked -- the balance finally cancelled after freeing up the 150GB.

Rich
