Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B1047191D30
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Mar 2020 00:01:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727389AbgCXXBc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 24 Mar 2020 19:01:32 -0400
Received: from mail-il1-f178.google.com ([209.85.166.178]:38809 "EHLO
        mail-il1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727324AbgCXXBc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 24 Mar 2020 19:01:32 -0400
Received: by mail-il1-f178.google.com with SMTP id m7so143785ilg.5
        for <linux-btrfs@vger.kernel.org>; Tue, 24 Mar 2020 16:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=kBJiFoP62Btw7m40L9NG8bWoeKz+V+mxbzRagCLUY50=;
        b=rv0KuQT4ucSYivBoGOiMerSORkttxuOCqyhq+177zLf64OM/XPw/avLpvoGVd01S52
         mzke/pLeKcZCvanNAQ5tCEpDo4llTcOtkXFiSMxbCf4r7xNjd7NNjMeM0d+vWfrqgQth
         K3530WtNPUArCaZCm3h1Dc7d+NyqR1gQdWzgi/9JXjYRFazjqcR1llGm9vgdHa5RSXbm
         13boBRUI4thbmS3wdFwiIf5gp9G7NkJ+4L446TVpyy3AA6pdV2sVmFonLI3kngdNQanR
         FHA81FO5eoezONnTYdazD7mrs17N7qALy6GNSpVKXgNFxiSicKanQqsVg8XnuiY2yyR8
         fjaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=kBJiFoP62Btw7m40L9NG8bWoeKz+V+mxbzRagCLUY50=;
        b=CeLs/heWv836oUrPbSPBTQYKNqYmjcNkCA/flhEyRj5TOW4aKcIQSiuXSVQKgAHgbA
         sjhNguaP4ky+I7TeUuSxQJJprKBGFmyjtqQgeDPtUbcaT12U+7MRafyRP4OD/QTAzl0H
         bN3/LbC0SRsQkOkogCIxsBFlgCrsOqm2GllR6QYJ5AwV6a4hQBb7NJgWxyyjvwPOq8KQ
         zUsujHHAUGeuMQngpLmlhCEn/MZrhIbKZ6FfkQx5dilO5cAb8tl7ZGM4EmCozPJVeKIf
         ThctX5AGJeEz7ReAjVB6Vx/yw53TZ7iu2FUwmZejz1+YNrwUo469WRfFXoh32hQOimdq
         5Gug==
X-Gm-Message-State: ANhLgQ0ROv7YhpG4fVDQycG2QX9VjO//z1tqw2qY8SCbZK7Nk72RvktU
        44LapaSNalbUjwUiTszpOa/71O+XpOydv+8qjwy9a8mH
X-Google-Smtp-Source: ADFU+vs+XZ+/Io2A656mG89BPk3S9OrTsTqJ0tfzq9PSW5tK6NmqXDisvixipuAOGvqEDnme15QbGL2DyTBvDmDHipA=
X-Received: by 2002:a92:c004:: with SMTP id q4mr716412ild.248.1585090891204;
 Tue, 24 Mar 2020 16:01:31 -0700 (PDT)
MIME-Version: 1.0
From:   Ganesh Sangle <sayganesha@gmail.com>
Date:   Tue, 24 Mar 2020 16:01:20 -0700
Message-ID: <CAJiQAnAJS-mSvQcC+8BActs53TZ6id+rc-CCO+DMWD9yJ810Ug@mail.gmail.com>
Subject: extent generation_id
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

hi,
i am new to the email list - and i have a question. Please let me know
if this is not the right forum for this question.

While iterating the extents for a subvolume, btrfs_file_extent_item
returns a generation_id - which is the "transaction id that created
this extent".
Is it safe to assume that every pwrite syscall will endup a generating
new generation id for an extent, regardless if it is over-writing an
existing extent (offset) or writing to a new never written (offset) ?
In other words, can we assume that if we have generation id associated
with all extents of a snapshot (S1) of a volume, then we delete this
snapshot, and then do some i/o(write/discard) to the volume and create
a new snapshot (S2) from this volume, if we iterate over the extents
of this new snapshot (S2) we will see a different generation id
(compared to the one we got from the snapshot (S1)) if the i/o
(write/discard) happened at an offset in that extent ?

Thanks for the help !
