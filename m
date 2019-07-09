Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 42A9162D26
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Jul 2019 02:49:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727125AbfGIAtu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 8 Jul 2019 20:49:50 -0400
Received: from mail-qt1-f179.google.com ([209.85.160.179]:42168 "EHLO
        mail-qt1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725857AbfGIAtu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 8 Jul 2019 20:49:50 -0400
Received: by mail-qt1-f179.google.com with SMTP id h18so12548598qtm.9
        for <linux-btrfs@vger.kernel.org>; Mon, 08 Jul 2019 17:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=a2LUdFo/eQcnOeupczvKVdR+AyY9Fw5FLz8BjOzmRwE=;
        b=tKMUqwV/AJN9iaZ7BC/gqzVW0pQTB///57YuWyJUbe9fIoRygRqSu6gilLnJDhDvf1
         IsZGEM5xVdbKG6CuEgtNwTvlxYeUPxeIf9YJLSvTiEx4F4uQgeI6ZfTlem4g+O2PVil8
         SO+OC1F4LpkGp6Kj1lcf+Mov3ZE9tpcar1IplGgCStCp6Oc5TMXmrEhvFNVeqkVR8kgd
         Lt8h1Cg1YyFtnma6T/kvFja3jx+gDygp+0fOw6g50wvoE3xJkHlXXM8uEDWLNRwBPzWw
         RhhDAsyMkQkFaI+E0VJOIN1ZSZ3VLZC1tcjufYz4hriy/BWgNlxXlGxBDg45XXdHsB9q
         v7Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=a2LUdFo/eQcnOeupczvKVdR+AyY9Fw5FLz8BjOzmRwE=;
        b=d4/SHm/zC/tB8u0ICv/RYkFkpBT71saHtveaLMfEwIyl60ZnzOWPeAgm3QWd+Xk0Un
         L9WKljtFbPmpo3/uJSnBmpe7dl14VeV1wf+mzrGGNf0AI49I4H+QBtuJGKlYp0IsBMoE
         UXR613/NQq/WWcCvhDBe1AujmYwemASbyo8hOv0t4q5aKsKttd4EnViNbK+2rA2KqUoV
         wyqGECKPgEbNW9PWi7lgXZT7yflKwN+hXFDM+bPrAx26pa0cjhaSm1gK3XywYgb0wXTU
         FLEQgfypi5RceG5E5LQG+NH2zMfT9mXHf5zk78ERMcOEGz00w0TCHnCgxT/ZwkE7bBhX
         AYvw==
X-Gm-Message-State: APjAAAV/0pRJF1vFTxvPz1Ux5scb46JHtHubZGABhumkPBxmht//Vt9Q
        nZGXDnu9If7bzqG58VNlwa3ZVo7DJ00Um03Z9U7ikLhHMnQTlg==
X-Google-Smtp-Source: APXvYqy7ge26iz5VAu1U16/JZmqhJCCs1xYZsQBp0EGbk6OtBXwTDD7vfl9bwvVA4ihdqj6LlOGf9t54oiyOsoexw0w=
X-Received: by 2002:ac8:45c9:: with SMTP id e9mr11815497qto.133.1562633389134;
 Mon, 08 Jul 2019 17:49:49 -0700 (PDT)
MIME-Version: 1.0
From:   Jungyeon Yoon <jungyeon.yoon@gmail.com>
Date:   Mon, 8 Jul 2019 20:49:38 -0400
Message-ID: <CANocb6dCc23jUTeHu9+YC5KK9X+ARNuL8aHm0PBT=UkKKXtrFw@mail.gmail.com>
Subject: Btrfs Bug Report
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi btrfs developers,

I'm Jungyeon Yoon. I have reported btrfs bug before.
Some of them have marked to fixed thanks to your efforts.
Additionally following bugs seems also fixed as I've checked.
If okay, I would like to close following bugs, too.

https://bugzilla.kernel.org/show_bug.cgi?id=202839
https://bugzilla.kernel.org/show_bug.cgi?id=202751
https://bugzilla.kernel.org/show_bug.cgi?id=202753


In addition to those bugs,
I would like for following 16 reports to be checked.
Most of following 9 cases end up reporting kernel panic or kernel BUG messages.

https://bugzilla.kernel.org/show_bug.cgi?id=202817
https://bugzilla.kernel.org/show_bug.cgi?id=202819
https://bugzilla.kernel.org/show_bug.cgi?id=202821
https://bugzilla.kernel.org/show_bug.cgi?id=202823
https://bugzilla.kernel.org/show_bug.cgi?id=202825
https://bugzilla.kernel.org/show_bug.cgi?id=202827
https://bugzilla.kernel.org/show_bug.cgi?id=202829
https://bugzilla.kernel.org/show_bug.cgi?id=202831
https://bugzilla.kernel.org/show_bug.cgi?id=202833
https://bugzilla.kernel.org/show_bug.cgi?id=202837


Following 7 cases run into assertion with btrfs check integrity options on.
https://bugzilla.kernel.org/show_bug.cgi?id=203279
https://bugzilla.kernel.org/show_bug.cgi?id=203253
https://bugzilla.kernel.org/show_bug.cgi?id=203255
https://bugzilla.kernel.org/show_bug.cgi?id=203257
https://bugzilla.kernel.org/show_bug.cgi?id=203259
https://bugzilla.kernel.org/show_bug.cgi?id=203261
https://bugzilla.kernel.org/show_bug.cgi?id=203251


Thank you,
Jungyeon
