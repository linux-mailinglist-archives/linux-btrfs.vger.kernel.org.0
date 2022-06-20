Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4462E5521FC
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Jun 2022 18:13:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243580AbiFTQMp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 20 Jun 2022 12:12:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244259AbiFTQMk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 20 Jun 2022 12:12:40 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13C2620F44
        for <linux-btrfs@vger.kernel.org>; Mon, 20 Jun 2022 09:12:32 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id f8so10146499plo.9
        for <linux-btrfs@vger.kernel.org>; Mon, 20 Jun 2022 09:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=hPeXp5c8gwagEkjmj1H5k+YFn5g56BXrjX655hyXCMI=;
        b=Ll29wQ6N3pJvhLOC4V5Y23Z9Ho2ypHTlXRr7zD9B28d46JiQ/2vfyvSBbEYJ5+SrtF
         IlhGqkZsCm6IyMSLsMXttnm7G7OntTyuuoCLfbgPC453ceptvs25CyXJij5luPqxBZ0K
         pdCV2ez0Nfpo+EXYkSzAUFG9Rpfn+8lDZ2ZUdHiZihF0BdUSY03C7rv+nPlOmYX6ga/o
         GoqVMD+nbdZz5HxuFNOGU4rarhklXrW8oUFt/y6XRVqbjZGwXTQlU8IFTKTMjYKpDBWU
         0pvojMRYRnc5/9IRXkn66aQOJ7CjHxv7fWVzBb1pz94lwIQo8DnpfeTkxw7W8c+XRoih
         BwbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=hPeXp5c8gwagEkjmj1H5k+YFn5g56BXrjX655hyXCMI=;
        b=o5M0kmDUmch3ZusiSjC/NYRuB9YS0QF6Ibs7eGrhuI803mY11PPBBu4ZX1eK9FHBTV
         wfSWMC+ZmH7Qv4XxeoQSFXnwcmANELKnv/LxF+R4qCxQ7K5OwaJf8YltoCijPWwWW4Qk
         Du/hP2zcL99u2XGJxgITOcg6dJV7n9rxud54hwsaPg8KQOfnnudbQxj8oFC+fpE94phO
         bf2NGugsSEzwNlfHIYS4NYADbphLd1vGw6PteoprkorfuNDmNcovIlCu7p8X5xy+ujTc
         Ls/GsFtDREiEMII8xreTbOO/ON0LSItRkvpCQR8zQWR+8mRwfL8qgnSXplBG36zGsJcE
         rwbQ==
X-Gm-Message-State: AJIora9LWkYSSbvONyltT/UFB6jEwpTVuzOJpex5F5r90/Ci9juEMyrR
        GKcO6KBpFerrb08rRnqCOQlqsXdg/8LsVigyt4E=
X-Google-Smtp-Source: AGRyM1tOxtJ0fxzauSxE+1DlFn+mZIu60dzBzKKVa2iW54dvm33t8RR1kZ67eUq/mzIR4tFF7t5DT3UdrXPKRcKl2mw=
X-Received: by 2002:a17:90b:180e:b0:1e8:3023:eeb9 with SMTP id
 lw14-20020a17090b180e00b001e83023eeb9mr27616236pjb.55.1655741551727; Mon, 20
 Jun 2022 09:12:31 -0700 (PDT)
MIME-Version: 1.0
From:   Leo Vbn <leovbn3568@gmail.com>
Date:   Mon, 20 Jun 2022 09:12:24 -0700
Message-ID: <CAGsM-A4BjEWUe5A19ESiCdjzVaRdqayGnAysqs-s2gSCZHPogg@mail.gmail.com>
Subject: PRODUCT INFORMOTION
To:     paypalinc608@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=1.3 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,SUBJ_ALL_CAPS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This email confirms that you have done a compensation.

As confirmed,


 Thank you for choosing paypal for pick up your order for bitcoin.
  Your pick up has been happily done.

The compensation will be shown in less than 5 to 10 hours pn paypal.

Order summury

Item Name         :    BITCOIN(BTC)


Memo No            : JSGZ684GZJ
Item Price         : 243.85

Pick Up Date       : 20th June 2022
Mode of payment     : Pp INC

If you desire to cancel then please feel free to contact our Billing
Department as soon as Possible.

You can reach us on +1 (8 2 8) - (4 3 6) - (8 7 0 1)


Regards,

Pp Billing Department
