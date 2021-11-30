Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A494463276
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Nov 2021 12:33:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240777AbhK3Lg1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 30 Nov 2021 06:36:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240776AbhK3LgX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 30 Nov 2021 06:36:23 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94551C061574
        for <linux-btrfs@vger.kernel.org>; Tue, 30 Nov 2021 03:33:03 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id l25so85139321eda.11
        for <linux-btrfs@vger.kernel.org>; Tue, 30 Nov 2021 03:33:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:sender:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=/GHCThJ8GFlfUk7inMGIdirKKW/1TzJdC9lhM/FFHlU=;
        b=BNFFf1GlGJ4Of5RDHHptIhZ+T3aQs7tvYvr9nE2geXIWaw9UqE1H8+qACVRTubcvU2
         iNtAwy8QpqY+2FtfXC0v6AlgSgLuo0UZRGmQWLF6EgTyyWZ/x0h/hrZZxmWsMHCb1SsU
         HONUmmlHnPFaeDI70qqhXPS5BZilaab7BCnTDTsxxppqS6I0tZFpSeqVxD6RIzP12a8P
         sTfFQe7eaU4B64MFD65FK5i4kiSDmzq8/DeNVaP9d0Ptr8Cw2Ga9BnXGPgbDWSww+B7U
         qgc7rp5eRBOY5Ta6jUcC31Lt4l+lgUXjWVO2o3jv84IH9p/epBWFwxDhg/pblpERAMyl
         KHkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:sender:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=/GHCThJ8GFlfUk7inMGIdirKKW/1TzJdC9lhM/FFHlU=;
        b=0jrGt+tfiRGR+/ZFnB6UPX8/XV9hWIGyp3GwGOt5cHJC6PEoDNxvhpSqeql3vrGPpX
         pi4WuN6dM0wiV4jgi0j6kOXTMaCiJmAY5CDjFTikQZz5wz4U4r6K1tccTP4V3H/4miwO
         C7TceRHgm95D6p+LYnraPMWGEMo2nGWl1viAe8hga530jYGiIHFQd7YTIxHoMBeHmjHH
         qtQ7puZj6qCT5VIOMmg9i8xYxcKPoz34w4SQ4iMQyRYqdJ0uNJAknRYV0lr5kmNOZCJn
         92O8EwEw5nQXav8PYdzSDyWftf1+Znz+bpHYLwY87ya3+cad9g6aqjp2NH0iDiCGL0bn
         bXcQ==
X-Gm-Message-State: AOAM533KZtF+YOTYAdYjnUU1A/J3PN4PfkqgB6H3hY2UEgPhZKAlCltu
        rvdMMMPipfWUTjcUPCpyFxaiU9TeHbM5ArDVmiI=
X-Google-Smtp-Source: ABdhPJzpvmkC27Y3TQny9QZhgzJQfQtz2eD3BCPz8q+olbvvD0I3/erUksBtqHAz+5HEO2gCFT9Z+zrLH2YhPw5I00U=
X-Received: by 2002:a05:6402:3590:: with SMTP id y16mr81753347edc.343.1638271981837;
 Tue, 30 Nov 2021 03:33:01 -0800 (PST)
MIME-Version: 1.0
Reply-To: mrmahammedmamoud@gmail.com
Sender: rmeshswami7078@gmail.com
Received: by 2002:a17:906:c20b:0:0:0:0 with HTTP; Tue, 30 Nov 2021 03:33:01
 -0800 (PST)
From:   =?UTF-8?Q?Mr_Mahammed=C2=A0Mamoud?= <mr.mahammedmamoud0@gmail.com>
Date:   Tue, 30 Nov 2021 03:33:01 -0800
X-Google-Sender-Auth: 55Y3P1IYTHGmqBxHtL5UF5pn464
Message-ID: <CAJ+Hgd9HYF3CHHcRSVPKiatPmn3Pv=DaNjHkiKTJfU8EeLfmXQ@mail.gmail.com>
Subject: From: Mr.Mohammed,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Good Day,

Please accept my apologies for writing you a surprise letter.I am Mr
Mahammed=C2=A0Mamoud, account Manager with an investment bank here in
Burkina Faso.I have a very important business I want to discuss with
you.There is a draft account opened in my firm by a long-time client
of our bank.I have the opportunity of transferring the left over fund
(15.8 Million UsDollars)Fiftheen Million Eight Hundred Thousand United
States of American Dollars of one of my Bank clients who died at the
collapsing of the world trade center at the United States on September
11th 2001.

I want to invest this funds and introduce you to our bank for this
deal.All I require is your honest co-operation and I guarantee you
that this will be executed under a legitimate arrangement that will
protect us from any breach of the law.I agree that 40% of this money
will be for you as my foreign partner,50% for me while 10% is for
establishing of foundation for the less privilleges in your country.If
you are really interested in my proposal further details of the
Transfer will be forwarded unto you as soon as I receive your
willingness mail for a successful transfer.

Yours Sincerely,
Mr Mahammed=C2=A0Mamoud,
