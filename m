Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D26513566B
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Jan 2020 11:03:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729955AbgAIKDU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 9 Jan 2020 05:03:20 -0500
Received: from mail-il1-f178.google.com ([209.85.166.178]:38470 "EHLO
        mail-il1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729882AbgAIKDU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 9 Jan 2020 05:03:20 -0500
Received: by mail-il1-f178.google.com with SMTP id f5so5230689ilq.5
        for <linux-btrfs@vger.kernel.org>; Thu, 09 Jan 2020 02:03:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=XmK3Rntp8J683mUVu/GwJeY+F0lv+3/qd4jxzu8G3lU=;
        b=UpdslEqP3Au5+aEhDTYdr3tj+jqo55/KaHCVV19FK2wpujPZ640ZPIfAKPeoFFbZMn
         c9PRXDjJcnHQeJlt7tz9hi12SdkmOok7zL+DOwVJ/lGcHxX2jwFtYppzSiNbUzQovSOF
         SZXAmL9q3pdVjgMouoP5DF1UM6/I8momdMt3LUW2uxHB2qsm7zaqczLCnEpQxdF4jEFs
         xL4MSltfosCIvT15tatI7rgvE0sEpWNNcK+RSb1Ra4ob4DSwk6+gV2ojOcBqqD0/xTGE
         TgjVvhQ+8ezEGdj7G59Djg65yPHZtn5QLNbPevJiVKeT1M0v3ZyCmH+IkTchkaTI/Q9e
         FqTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=XmK3Rntp8J683mUVu/GwJeY+F0lv+3/qd4jxzu8G3lU=;
        b=o5b4wVLybFR/bpw8zrqvo6nbjZw1vDCanh/qEh7eHsOSCEePEz14AVnepUwHSDayn0
         AX7yIxDEQ/NOeHH6/aG63txYENBrth8Az47u3rUeGvgxz4VKckL7vI6kGJ20LN8euMzp
         gGAc6HNGofUQ2YHXD+0A85C83qHHEujbQg7H0mnk6dFNOFkP4pbnAL098n+kxTnQQMoe
         WclQp4YiumJ488crZPWuH7EtqkqzoH+GqfDrOeammqJICtgm6BUYEel6JJcMJARruyqO
         P2eVnipfdgemxDlaZKDARyfXhkj5KUdgkP+o+7dExOOdHTIioL0JIUUTS+4SLEL6WX8P
         UdxQ==
X-Gm-Message-State: APjAAAUleE95PFJSsd5LSO5Yt3ZFDDJcA5VPI40EoCa0rlBKMHkxYXDP
        VrjVB8h6SL+GHw6K6qO3F5DmCdosJxscaL138+gGpl13
X-Google-Smtp-Source: APXvYqwEjds8JkbPUAjAhTOMKTtQF5Q1apfvGDDlFzpXGFGUZzyLUFqTFnInow6XIOHvajcV6fJOAS1VKRp8XSb0HYE=
X-Received: by 2002:a05:6e02:5c8:: with SMTP id l8mr8203080ils.287.1578564199364;
 Thu, 09 Jan 2020 02:03:19 -0800 (PST)
MIME-Version: 1.0
From:   =?UTF-8?Q?Sebastian_D=C3=B6ring?= <moralapostel@gmail.com>
Date:   Thu, 9 Jan 2020 11:03:08 +0100
Message-ID: <CADkZQakAhrRHFeHPJfne5oLT81qFGbzNAiUoqb3r0cxVSuHTNg@mail.gmail.com>
Subject: btrfs scrub: cancel + resume not resuming?
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Maybe I'm doing it entirely wrong, but I can't seem to get 'btrfs
scrub resume' to work properly. During a running scrub the resume
information (like data_bytes_scrubbed:1081454592) gets written to a
file in /var/lib/btrfs, but as soon as the scrub is cancelled all
relevant fields are zeroed. 'btrfs scrub resume' then seems to
re-start from the very beginning.

This is on linux-5.5-rc5 and btrfs-progs 5.4, but I've been seeing
this for a while now.

Is this intended/expected behavior? Am I using the btrfs-progs wrong?
How can I interrupt and resume a scrub?
