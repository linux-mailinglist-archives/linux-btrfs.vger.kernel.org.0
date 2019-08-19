Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 780629508D
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Aug 2019 00:12:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728657AbfHSWL6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 19 Aug 2019 18:11:58 -0400
Received: from mail-lf1-f44.google.com ([209.85.167.44]:38610 "EHLO
        mail-lf1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728568AbfHSWL6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 19 Aug 2019 18:11:58 -0400
Received: by mail-lf1-f44.google.com with SMTP id h28so2530709lfj.5
        for <linux-btrfs@vger.kernel.org>; Mon, 19 Aug 2019 15:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=bZhpJ7wxOePr/sPTIIAcy5vpF0IDzvKX9wckMISbLQI=;
        b=Xr7uP3rJVczcFo9913n9zO9/9ChhLKWDRJ1DR1lAvDQdvvSQipsONzlPocI4nwX7tf
         koOzNSc2lkd3UhICEJ9Oz07AQokeKy/4lVa/oO2JnJd0DzFTY5hdJ6vFfyAUREXo923y
         Ec04y0HQUQiF+0aFFNJMhVESTwSt1tvx49T/F9GyNIxbVUEtGYpR/mZzqVwEGB1DEBpJ
         /U3HPgdpfNup942n6H30vGGmEC56W6zSjuN2PfT0gIvXG7iDK36RB7OtWsOP8Sv+VL61
         i3d/wCCs0ocG0ubhNjJnB9iqrAvRiE9WmS/WkTIExbnF+bzKcLYWOsLvt4AFKBPzXI93
         /QDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=bZhpJ7wxOePr/sPTIIAcy5vpF0IDzvKX9wckMISbLQI=;
        b=q0zDaxG+VvxV+cxiDbx21ziTDGbn2xC5crBEF2PqZVnlGdFrEQdcPiavYclaZfmVb0
         e3mqmmoUimP32a0UpwmjomOnQ6V+qwENJuak8HnOPIbmOB3nbtkB7zT6wPys3na8/R8s
         q4FgSabAwdKJ1abYCL8MJzQjOES58lWqSgHd3GbsQUbAsB2l6niCSpD52WbRzxJp7pmj
         sTp/NEQIjMKbKz3oZGrjrAm08WLs3yE29eiExfwRCC8zBXrdCRQaLxV69O1UOISOhpjt
         K8Y/uzydiRkh7zfHI1CmDSC7qpSUNj+AngRklZz6mInjYzBbxBGpA1LpTefkwwZ9B/uJ
         U7OA==
X-Gm-Message-State: APjAAAWmg+h26MnpmmZF+Ol5nAwc0s0hLw0Svu0jCIFYEvSQxbjOG2S3
        JbjaZSvcRPUSibx/Ae4XPYfZRLEye2tRd8eeUhtxML/+tCk=
X-Google-Smtp-Source: APXvYqyLQLWmqPEo6/dH0mPe7KiviH0O/7Y3r5TpTiHSqzjNpy1fDAhpaHzDrR1NyXFF+cblaJgoo5DHoMMfdS4MGy8=
X-Received: by 2002:a19:c1cc:: with SMTP id r195mr13037797lff.95.1566252715655;
 Mon, 19 Aug 2019 15:11:55 -0700 (PDT)
MIME-Version: 1.0
From:   Kris Bennett <krisbennett82@gmail.com>
Date:   Tue, 20 Aug 2019 08:11:44 +1000
Message-ID: <CAMG4Rq=0wHk7DdGO4E7PEFqqtYTw8ivCi=CrXWp2K-nkga8yrg@mail.gmail.com>
Subject: Deduplication Idea
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I was wondering when in-band deduplication was likely to make it in to
BTRFS as a standard feature and was wondering if this could make
network transfer more efficient (outside of the scope of deduplication
in just the set of data that was being transferred)...

For example:
(In this example for simplicity I am just going to use the eg of whole
file deduplication, not block level)
I want to copy file A, B, C, and D from computer X to computer Y; at
the beginning of the backup the hashes of each file are sent from X to
Y, computer Y already has a hash that matches file B, in this case it
generates a hash on said file using a different method (in case it was
a false-positive) and sends it with the file name back to computer X.
If the returned hash also matches file B it sends A, C, and D,
computer Y realises that file B that came in the initial list is not
in the new list and knows to reference the file content from its
existing match it found prior.

Of course, deduplication should also happen within the scope of the
data that is being itself, for eg if file A, and C are the same, their
content should only be sent 1x... but this would not necessarily need
to be calculated in advance (prior to all of the files being sent),
unless the user wants a more accurate calculation of time remaining.

Thanks,
Kris
