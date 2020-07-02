Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C105B211EC2
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Jul 2020 10:28:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbgGBI2g (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Jul 2020 04:28:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726042AbgGBI2f (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Jul 2020 04:28:35 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B43BC08C5C1
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Jul 2020 01:28:35 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id e15so22728384edr.2
        for <linux-btrfs@vger.kernel.org>; Thu, 02 Jul 2020 01:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hgZWN2m4us3FLlQvm6TSq656rWnG8kDxlpZgg6lQMfI=;
        b=ven6Rt92VyYHM1Wdckragdpbbf4MLQHdLipQuYIoaeolbjHwxIjywfcEgsv2uEL8mk
         gGCyZgS61YN5v3PanA5BbE3qlubkcRxRkqle4RgirUGA49S+4gdDVOrIVzF2pXRWMTWq
         SQ/+sHTbj83ObnXMsl/pTDlthGmDQM1Cl4sQZyzEZk7NYzNap9RMOMA6OP3UN5nRe5Q9
         rlTbRn6hbvKo+RZtaxyoPpo3tkQerEnK9L0kvvIRPxRAPWDIuh83+nUPk1YEDSgKC8kp
         1XWg7YXbLMmuL0KMdwM99iNAbzwiisulCJR6E5X+pNEl6rPqvaOz5aRjhFOn1//llwCx
         vN5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hgZWN2m4us3FLlQvm6TSq656rWnG8kDxlpZgg6lQMfI=;
        b=KGWhf0ITX41VGjPTD7qYPkPv7mVRqmH2BuU6YlJ+8EXTMA8oKMFjZUc2j89F3Zmk0V
         6PsisGZmYo6stOHJEDaIgqigmEXkENaRd0qQBgjOTYaJ7Z+B1/1j+szFEarrWdcm0iLc
         0MGhn0qnwr3i3UgitiiV/uQ0BOvLA3GJAzNMq5Wa9GsrJk8k9JtEPrJJuyzHQ2EdbjNi
         Om0kUcxQf/yiHqL/4Exr0EDyl4PI+qN/Wc2N4BkpfgR3/bv2S1Ng3Jb3VsSNZMcI5pCE
         +NrbvC3chWICvgX82kd5r1y9y76JrTHJ0gFPgz1JOwSdJHMmK77QbU6lA322h3I5tv3u
         60SA==
X-Gm-Message-State: AOAM530zJzhz7ILICoqKLzW1GumWHDS02H40WqFDJG5buvvM6xJ4kekX
        4eFLIc/wniX+cEaARZs3lfKRbjKi9j4NT4trBJk=
X-Google-Smtp-Source: ABdhPJzoV5dmv1ehtmHDTMvI1sogjz8AbYnntrxml6Tkukzvt5/XV/AOC0dz6JDwtIgnQQii06t88tI90tcgX7uUFiI=
X-Received: by 2002:a50:ee01:: with SMTP id g1mr26004597eds.264.1593678514316;
 Thu, 02 Jul 2020 01:28:34 -0700 (PDT)
MIME-Version: 1.0
References: <16bc2efa-8e88-319f-e90e-cf8536460860@gmail.com>
 <20200618204317.GM10769@hungrycats.org> <65eeb90a-e983-2ae8-14ad-79bcd2960851@gmail.com>
 <20200619050402.GN10769@hungrycats.org> <20200619131117.GD27795@twin.jikos.cz>
 <79672577-6189-10fe-b4bc-8cf45547b192@libero.it> <20200622224556.GP10769@hungrycats.org>
In-Reply-To: <20200622224556.GP10769@hungrycats.org>
From:   "Lakshmipathi.G" <lakshmipathi.g@gmail.com>
Date:   Thu, 2 Jul 2020 13:57:57 +0530
Message-ID: <CAKuJGC_eDi3isqJHxn6XG8GerOthYeVTb1j5cTPYSiuV_oFgaA@mail.gmail.com>
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

Hi Zygo.

>dduper is a proof of concept that is so much
>faster than the other block-oriented dedupers on btrfs that it overcomes a
>ridiculously inefficient implementation and wins benchmarks--but it also
>saves the least amount of space of any of the block-oriented dedupers on
>the wiki.

Regarding dduper, do you have a script to re-create your dataset? I'd like to
investigate why dduper saves the least amount of space. thanks!

----
Cheers,
Lakshmipathi.G
http://www.giis.co.in https://www.webminal.org
