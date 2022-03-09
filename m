Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82BA84D3C23
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Mar 2022 22:36:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236347AbiCIVhY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 9 Mar 2022 16:37:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235179AbiCIVhX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 9 Mar 2022 16:37:23 -0500
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 543FCF9FB8
        for <linux-btrfs@vger.kernel.org>; Wed,  9 Mar 2022 13:36:24 -0800 (PST)
Received: by mail-ot1-x32c.google.com with SMTP id x8-20020a9d6288000000b005b22c373759so2710226otk.8
        for <linux-btrfs@vger.kernel.org>; Wed, 09 Mar 2022 13:36:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lUFMmcI44RntAMqgdHXtLdOP485Pu3dqtAalp/qwyRk=;
        b=giWchPzIYrvdwZy+RBnkeXTaTgn469JzCd7BKTm67BTkoUuQ8dQU6BomWmtLRE8g5A
         71B03WCdE61gqsTg8A1PoJviDcfVB0LPw4u8NiTnH/K4FkUDfeANhJmQBf/p2Fvpv1hj
         CURxgW+9UW7FRRTjhH9YTdX5mQ+tPQq7VRuxjw+bBHqWpksEPQZwD4vDDquVOJozVb6z
         NI3AI9PaiHvkgHJj62ukDk6rgYINgk6aHxcdLbAj+1VTNgtP+AGytNyy664v0+ZnrCLJ
         SMRPqgxJ18BbXTXpsi/q/+X+iE9Iy25MsRy550vaWTZeFpPWtKgdpBaw2v9pJb4r+k2G
         kMBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lUFMmcI44RntAMqgdHXtLdOP485Pu3dqtAalp/qwyRk=;
        b=2yNxLHHmJlG1TMnLnX6JxeFxBZBOB9hH28XB4k1k4MMFczCCirjLfrZ5rNZbZpsndI
         5yVCcYZ/6Za2rdIDSmVt5uu/Whtt3Y95x3u2hbTQNUQtOY//UygGBQop1D1Y+sfO0wyj
         D5XfmfY5MIdZcJ76OPqqU9z9Q7eHgDx0ajw/CR+a/BwxPsLx/Efw7tLAXfarISbWnG4b
         7KYTqnUAqOiK0kNXHBqtawCdIeub6VCAedOqT1v4x6cVz7KXEh/XrGLjlybjO0pQfc7l
         tMd4yiVaxy9I9ipqUw4RP9DCjFFSwsZPUd1V3lBX9x1SNsKoRqxfvwsM6pYHfhzjzEZX
         /TLw==
X-Gm-Message-State: AOAM533SHZr7g16Sk1ZxHVCHy3/D6ZDjgbDKhDAZLf5c0V02jXQqk4B6
        8y8Jj7CdA7CAG4eeKwNxSJouHttwzy3cV75fbQb6Xoa51is=
X-Google-Smtp-Source: ABdhPJwelwo7Yqo3fkUF76nXM5e1g0d5WA69Hpw3kgC7LDPD4U/sGA8ppqtzhHjDGaPxL+Ob3U83ASc6UGn/CwCwDGs=
X-Received: by 2002:a05:6830:4406:b0:5af:d53c:18f with SMTP id
 q6-20020a056830440600b005afd53c018fmr963646otv.236.1646861783597; Wed, 09 Mar
 2022 13:36:23 -0800 (PST)
MIME-Version: 1.0
References: <CAODFU0rZEy064KkSK1juHA6=r2zC4=Go8Me2V2DqHWb-AirL-Q@mail.gmail.com>
 <87tuc9q1fc.fsf@vps.thesusis.net> <CAODFU0py06T4Eet+i0ZAY5Zrp5174eQJOCGh_03oZdDXO55TKw@mail.gmail.com>
 <87tuc7gdzp.fsf@vps.thesusis.net>
In-Reply-To: <87tuc7gdzp.fsf@vps.thesusis.net>
From:   Jan Ziak <0xe2.0x9a.0x9b@gmail.com>
Date:   Wed, 9 Mar 2022 22:35:47 +0100
Message-ID: <CAODFU0oM02WDpOPXp1of177aEJ9=ux2QFrHZF=khhzAg+3N1dA@mail.gmail.com>
Subject: Re: Btrfs autodefrag wrote 5TB in one day to a 0.5TB SSD without a
 measurable benefit
To:     Phillip Susi <phill@thesusis.net>
Cc:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Mar 9, 2022 at 7:47 PM Phillip Susi <phill@thesusis.net> wrote:
> Jan Ziak <0xe2.0x9a.0x9b@gmail.com> writes:
>
> > I noticed this inaccurate wording in my email as well, but that was
> > (unfortunately) after I already sent the email. I was hoping that
> > after examining the compsize logs present in the email, readers would
> > understand what the term "file size" means in this particular case.
>
> I don't understand.  You stated that the size decreased by 7 GB, and the
> size figures that followed appeared to bear that out.

The actual disk usage of a file in a copy-on-write filesystem can be
much larger than sb.st_size obtained via fstat(fd, &sb) if, for
example, a program performs many (millions) single-byte file changes
using write(fd, buf, 1) to distinct/random offsets in the file.

Before running "btrfs fi de file.sqlite": the disk usage of the file
was 47GB, 1834778 extents

After running "btrfs fi de file.sqlite; sync": the disk usage of the
file was 40GB, 13074 extents

Sincerely
Jan
