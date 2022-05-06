Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B192951D1AD
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 May 2022 08:56:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386688AbiEFG6k (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 6 May 2022 02:58:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242356AbiEFG6j (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 6 May 2022 02:58:39 -0400
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D6F866C9B
        for <linux-btrfs@vger.kernel.org>; Thu,  5 May 2022 23:54:57 -0700 (PDT)
Received: by mail-lf1-f51.google.com with SMTP id bq30so11043077lfb.3
        for <linux-btrfs@vger.kernel.org>; Thu, 05 May 2022 23:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=NRsKFGIDkGHr/C8V+t8DnhNZU5FADxmt1ukPKfs0+qI=;
        b=CKKPSY87I9vOJIq8Lw5+2KhD3mnYnNW4xIAOpq3HWA8yEtsHU3Rci9eWr781YqoO9w
         M7DtNX1JKGMhi6F7ki+amGx68OnjhRLfTHZAU/H/DkXc/rmnHDxBRJ5E4X8Zqf2Q3YX3
         W6zOe9+sSqa3+NRiAHNdRyqToLCevlFwohkdwmQQeo2HOBpA/HJAgst+tjU62+18Gstl
         v3sra34RKhYs8xswBYhxdCegYoWYuNF4MjLhbDTHJEvEQyMkxKYRhCZYYinRhoujhKOX
         T8QTuPbRYkp4LRuA7E5jSdwgjCKiQ63fRfHVIHR441uECkNgaSz1jW+okZZ9LANKRR3f
         DyCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=NRsKFGIDkGHr/C8V+t8DnhNZU5FADxmt1ukPKfs0+qI=;
        b=A25hR+fXVNeo4P4p3iTMP5AfX1OMLu9BVuFhB/qZqR0wwvYABYGIQt3AcISrANKvaX
         fbZPrtQNUnwWKMs4M2jf/d4go0Z3Cdm3Rl7Pn1HluWnJuyBovAWrd6X682MeI2L8ExNH
         B+9fXR/+OVwSUYJCjuXkY9+xXSDenZdCdv2lt1nrtwSm67q5b9bcvU3VzAQlag3YBI5e
         AuaRVb90KTXT1WHWhZ/Fd7KiJwQSOavNazUAEdqra6kakpFCHTu7CLQ/JnACJeYwNkYZ
         Pq2lvozEmwSrIDTZdW/MY3idHC3VgeGSsFsVb9YmGMjRRCl5o6XvXddmOjvbotR9UJmE
         3hfA==
X-Gm-Message-State: AOAM531Jb0fvVOPb2Tiv2Zg0Y/48hcpADR9vn1TPyV59k12fOTGB+7Ez
        FhthtroRxWN4CYblWG5tIrcRee2lLUZIiawuLMc=
X-Google-Smtp-Source: ABdhPJz1ftXcG0NKYRMj+l5gTNFCGmHZyyUiu/uop5pWFrkA3liDz7L/pbZINjGMLgf8wKD21eFGPdZ7tzuYcXZ67nk=
X-Received: by 2002:a05:6512:3d28:b0:472:6386:9eab with SMTP id
 d40-20020a0565123d2800b0047263869eabmr1579846lfv.484.1651820036111; Thu, 05
 May 2022 23:53:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6512:3181:0:0:0:0 with HTTP; Thu, 5 May 2022 23:53:55
 -0700 (PDT)
Reply-To: sgtkaylam28@gmail.com
From:   sgt kayla manthey <akouviayena15@gmail.com>
Date:   Fri, 6 May 2022 00:53:55 -0600
Message-ID: <CAAk+1uV1vzSnexBGJdYg1dCdwB7xVyp0mNzKw5SCADLhF9akDQ@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=4.8 required=5.0 tests=BAYES_40,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

--=20
=C3=9Cdv=C3=B6zlettel,
K=C3=A9rem, megkapta az el=C5=91z=C5=91 =C3=BCzenetem? =C3=8Drj vissza
