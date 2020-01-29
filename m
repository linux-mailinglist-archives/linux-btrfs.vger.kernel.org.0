Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7617414CABF
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Jan 2020 13:22:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726623AbgA2MWw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 29 Jan 2020 07:22:52 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:45005 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726067AbgA2MWw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 29 Jan 2020 07:22:52 -0500
Received: by mail-io1-f66.google.com with SMTP id e7so18301848iof.11
        for <linux-btrfs@vger.kernel.org>; Wed, 29 Jan 2020 04:22:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=6TnZdYJpvgsp5VNY+lq02FV/KNwAvoxpbZCGTLhuaJ8=;
        b=ENukJvBfmAGtPhjCZ3td3MGQAlXq3fsGLMcdJJgK6tV3a0gPKBSMII5gGJh03H5lC1
         ++3WYFlrf/E4Hze9ATio+pKeGHMdphvCTeddTCc8VQjgNYMWPSLHidhMcs33elxhA+Lt
         jyg4dUNFQeBxlyS91JCfIqxi2mvv6uEarBqzReaIs5h8TX1ID/RQcy3+sN23N7dQ3qTC
         4aZ7zuYwxAm1zgSmq+Zp9rAgSGw5tvWyUqG5uWtTkvsyqc/orihjt/5jQnmSrLeZwUE/
         eSuJGbD/6uNAGxLxRYsj3UXZX9i57kn6hzecdF0F45QmVYPpklUBfIk9j5ndMDwp/pRl
         azVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to:content-transfer-encoding;
        bh=6TnZdYJpvgsp5VNY+lq02FV/KNwAvoxpbZCGTLhuaJ8=;
        b=GWgeBF1lz53ccRFz7fDipJaRrL22irVIM9QnGfBM55XzgJ0vKmEtX0dJLXc8uCTGQI
         L0kf7t2+0GZTYfYq/fcrdVu7FtBFdUh672fKPZmvklJO/wvUPEiS37PWtO/lnCHSx/a8
         Z3uHdtvM+qfyNflrhA3O5iz0NZhRnjuKSjKwjVGeAXrmAi4K+W3DloZsVfvkCO/Is2Ut
         /W5nee5MgQpAISzhztfVvBSTRSDrG1V997rO44jozYrV6Y24dlFVZTKLmrJiOwDUIVTo
         NX5QA6zms11Vj7Wr0Chq3boxnW3nG0MD4mzlo/3UKI7+mWPV3oC/aJIrPsS8AM2vQape
         SJdg==
X-Gm-Message-State: APjAAAUBktIAe+CXfz/0JEGdpeDvEyoWiAouN01kOsKXPITxW6KUrdaW
        H7et6cXPwzlD062mWjA/8ZZMHeTNsxoVRQ+yPGI=
X-Google-Smtp-Source: APXvYqyEKGcheRooTCn/v+gtqHPQDAlhNloOcK8Y9rELh+fnUGezBpHSYia+gm6MklfBD2ON/njlZmvD/9BC+GxLe/M=
X-Received: by 2002:a5d:9514:: with SMTP id d20mr21277995iom.198.1580300571109;
 Wed, 29 Jan 2020 04:22:51 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a92:c8cf:0:0:0:0:0 with HTTP; Wed, 29 Jan 2020 04:22:50
 -0800 (PST)
Reply-To: sandrajohntg@gmail.com
In-Reply-To: <CAEeyeWr2wnoVYJ5UzHVv7TURTgc07Zber2LVFSyTH+gYgXM7hA@mail.gmail.com>
References: <CAEeyeWpn6_RVXVgT6ULM6ERC-DXcpJpdvxr_1YX1-+Nk0vmBNw@mail.gmail.com>
 <CAEeyeWqN7cUKpr=6QR1x+LhqHXQ2YMFKsdXqWvEXOwG4UgFLpA@mail.gmail.com>
 <CAEeyeWr2FfUcXSps-qY+zCxK85He8ZN1tK_ug+SN6q2nyqcJCw@mail.gmail.com>
 <CAEeyeWqA1XSJEh54yxrp5HOAAZC_syASmvU1q7VY190geFxqtQ@mail.gmail.com> <CAEeyeWr2wnoVYJ5UzHVv7TURTgc07Zber2LVFSyTH+gYgXM7hA@mail.gmail.com>
From:   Mrs Sandra John <victor.williams1000@gmail.com>
Date:   Wed, 29 Jan 2020 12:22:50 +0000
Message-ID: <CAEeyeWonAdRv8BRF6qWyTEFA7kw8wSrcsGvsefrFVdS8PciQpg@mail.gmail.com>
Subject: Fwd: From Mr Thomas McMahon
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello Friend

I'm happy to inform you about my success in getting those funds transferred
under the cooperation of a new partner. Presently I'm in India for
investment projects with my own share.

Meanwhile,i didn't forget your past efforts and attempts to assist me in
transferring those funds despite that it failed us some how.

Now contact my secretary in Togo, her name is Mrs Sandra John at(
sandrajohntg@gmail.com) Ask her to send you the ATM CARD containing the
sum of $1.800.000 which I kept for your compensation for all the past
efforts and attempts to assist me in our transaction earlier. I appreciated
your efforts at that time very much. so feel free and get in touch with my
secretary and i have instruct her to ensure that the amount is released to
you.

Please do let me know immediately you receive it so that we can share the
joy after all the suffers at that time and moment, I=E2=80=99m very busy he=
re
because of the investment projects which me and my new partner are having
at hand.

Remember that I had forwarded instruction to the secretary on your behalf
to receive that money, so feel free to get in touch with Mrs Sandra John,
she will send the amount to you without any delay.

Yours Faithfully,


Barrister Thomas McMahon
