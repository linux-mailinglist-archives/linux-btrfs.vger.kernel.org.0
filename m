Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68D6325381B
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Aug 2020 21:16:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726953AbgHZTQg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 Aug 2020 15:16:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727998AbgHZTQd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 Aug 2020 15:16:33 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 404BBC061756
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Aug 2020 12:16:33 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id t14so2909016wmi.3
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Aug 2020 12:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2iowpjbw6FRmVjshB7UsY9RLTM3KatoaooqfWfixcWY=;
        b=mV1lmLTb2f0pHm0VqPV+2P1vV/SXt33a35JOn5vBDsBXR172Bt0pF1RfjUdLUcvYZN
         VZYhG5O8IMMCie8TGNzNRvqduMh8r/32GzuMCdsx76R4qGPn2kg68i6wT/LA1iuntnM8
         dsmAv7TScoy9/AI0CLoYKkt+yDmJm1lsUykNE4UStXk+85dYuTz+sTnhGyStGqOLxP27
         EvlK4EJFJB6/WCsLZXnd1CSM248ABDyTu9Tkjl/F/flzt6cmYUh4MiAfVEIqpcNYZL41
         qqf5iaYYDiDbMm/Iv63cB/WZslic/8mKWmb3HheZEjPHwg1PVVMlzcWvor0ANtG5bwmN
         zntw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2iowpjbw6FRmVjshB7UsY9RLTM3KatoaooqfWfixcWY=;
        b=ZVu6c1pOTmFMPB6cEX/3jI1DYqpmqGfcNRxPJbp3XcVXiJ0KdxEib43H9VN4juUlTi
         dUgGoxMq4+GzBAcQj3fEpTthd8vepUGn7L3kljq7atihJA19b0HA/FGNS6XfcD0qPFg/
         hohfs8aWNPPGAivjWqeYbFeVBXGHbzqNbSYb9khdE1JwlDk2aPVgqHTqReB1fgM7s5bX
         2zySp1w+iSjkTWLVVVWr02pkhk1qb3hUC5PJr+9hIDFM4oYCjNXOt8pqvUvm9q7Y1XMB
         ai3w3gcXzpssH4HTurUGP2B4vxECPBAPxnV59x5YT6QRFJ89AAtlCv9wEa1ArVv84W1b
         9LIg==
X-Gm-Message-State: AOAM532o3RXtAJipa+2OrdJfAsWP1rojUDfOgPGdNlW2PsTvrDnTgBmt
        hWlQ2I82hIlsG1tfse4RaOly6XuonsBbHrFfrRTvvQ==
X-Google-Smtp-Source: ABdhPJyHSF3YNrBZ/+ygpsH9t3GN8hpZcA2VuvNohyBKrjVzzwV4l3nNOl+zqoF0PLJUrjZGKYJ9Xoyy1TJIshuZbFg=
X-Received: by 2002:a7b:cc13:: with SMTP id f19mr8227326wmh.168.1598469391994;
 Wed, 26 Aug 2020 12:16:31 -0700 (PDT)
MIME-Version: 1.0
References: <bdJVxLiFr_PyQSXRUbZJfFW_jAjsGgoMetqPHJMbg-hdy54Xt_ZHhRetmnJ6cJ99eBlcX76wy-AvWwV715c3YndkxneSlod11P1hlaADx0s=@protonmail.com>
 <CAJCQCtR3gbJxJn24qyDfHWh9kQG7BSC=NnoGHmRKPnaQ+P7yyg@mail.gmail.com>
 <8oT9s0Jlzpgp2ctPAXOixSR03oOiPXaitR0AiOkNdBsYHwjPMfjK7CoVAPXuvj71hiUTH-fKoSevAM-To8iSPPBvGRvZeBkU0Nd1_NPonyU=@protonmail.com>
 <CAJCQCtQH3h=NNr6PX3HZp7SbkgqZtNNdihi4aBMFvx+DN79XeA@mail.gmail.com>
 <6LDov933WqF3kLH8jtkEh-pfK6pRe0o6-Y9l3NcO2mVhswDL7rhbHyda71OnztoJKfgqqQT9jj1Ba52lz_ugNFmmRtzN33BlSa5pCvds0F8=@protonmail.com>
 <CAJCQCtQDt=x7WCX7KhWz_pPn4yB1YdZm9jN29jRuQDFy=ZTOjA@mail.gmail.com>
 <emBWetDIaC_TYsBRNRlPcz-yLjIOxlhIBny_K9bTqHxLO_kdKRZlGjMoHrVj4CwZ8aZAnMcXEyCj95vBFBxxOvJ1AANQr1sbeQ_CfZOrTH0=@protonmail.com>
 <VTDsoZlxoD7U7UxD61VnBts_awxM0n5PgKgeH-fCQOy4VeCCCj27DmdMt_oP490t0cKWbsY9qlK1hci8o-1uD7vtBcVQLub1Gl3JjIGU-o0=@protonmail.com>
 <CAJCQCtT8gLGNU6E+f=eM9SBPa4+tG+K7AbiCd=KjD2o8QrpxpA@mail.gmail.com> <dHPyoaNUuxoqxJjpSUjcxZvk21ew2ObKWFFhX0efJKBqjG8m27px3mPupviQuM3HYQDEcYQGFQ9jOprBuAX4x1Em3oVOyDl6EhKwEJSiuXs=@protonmail.com>
In-Reply-To: <dHPyoaNUuxoqxJjpSUjcxZvk21ew2ObKWFFhX0efJKBqjG8m27px3mPupviQuM3HYQDEcYQGFQ9jOprBuAX4x1Em3oVOyDl6EhKwEJSiuXs=@protonmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Wed, 26 Aug 2020 13:15:47 -0600
Message-ID: <CAJCQCtSVMAEZP5OT77yCEBw9Z3C=oyVKcicWbRV9p_+pKcRwoQ@mail.gmail.com>
Subject: Re: [Help] Can't login to my systemd-homed user account due to
 fallocate failure
To:     Andrii Zymohliad <azymohliad@protonmail.com>
Cc:     Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Andrei Borzenkov <arvidjaar@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Aug 26, 2020 at 1:09 PM Andrii Zymohliad
<azymohliad@protonmail.com> wrote:
>
> Ok. Thanks a lot for your great help, Chris!

No problem.


> On Aug 26, 2020, 22:06, Chris Murphy < lists@colorremedies.com> wrote:
>
> The fallocate problem is still real, and that might take some time for
> Andrei or someone else to figure out why.


Actually, if you can reproduce the fallocate problem and strace it,
that would be helpful. For sure, homectl deactivate, for starters. And
then just 'strace fallocate' that file the same way you did
previously. I assume it still fails. Put that strace into a text file
or pastebin (month expiration should be enough) and link it.

And also paste into your reply:

grep -r . /sys/fs/btrfs/<uuidofbtrfs>/allocation/

You'll need to use the uuid for the btrfs that has this file on it.


-- 
Chris Murphy
