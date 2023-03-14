Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAE4A6B9A64
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Mar 2023 16:53:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231523AbjCNPw7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 Mar 2023 11:52:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231367AbjCNPw4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 Mar 2023 11:52:56 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFA9A72B1F
        for <linux-btrfs@vger.kernel.org>; Tue, 14 Mar 2023 08:52:22 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id a2so17064269plm.4
        for <linux-btrfs@vger.kernel.org>; Tue, 14 Mar 2023 08:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678809141;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sNH9BgItuJxPa+eQE400FTpJfbjpuq0SQX7Oz1zEQmQ=;
        b=cFJijmUD8C09bNZ2xmj8OUhKhAbU/nYbYy9zlrkLV7OiEs3QomRdZjEEhnfrwesIJ3
         d3A12f0l7N0DA+i85NoXKpgxYkd0GQHXNgUuRG2vUMBWmM6pG+ekpxA/6h5HoECwK9Ky
         VFVoZYgxZ7up4NoxBjXaqpRsYumU7/zijMoOpVI15Vfad7ah60tcCJSvISdGYwX+BwPu
         mF9A8Sd5TKbPXcam5Bz5QVKIFy2EOZ8jU3DXzwNUnoq/4mJ4TZET9KIPRwFwQoegLdnp
         94n3SPvjH9BnFI4c72n3JyJMdIe1QS0RUgRJzXsvbLRlJDWHzhSg058E8V+MZPhd8v87
         QpYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678809141;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sNH9BgItuJxPa+eQE400FTpJfbjpuq0SQX7Oz1zEQmQ=;
        b=drR6EpeYRViuaEph0OYPFeVXevz+aDZZxYmPfyRk3O6Umf8dP2+SABAuckKdRQzc07
         qWmSf67LI39b8cgSqkzaudA+P5KHP0BucC1QLlPglSVpkG0V6G89BcX3bz9uBcygw3FN
         4jUWl4r12Pl0jikC8YDdS4ONiazSCdVGIxhqXySBE+vfJiBPDzyfttIweqLHIKYZr/ho
         azT74YEoHWbAnA0L9MlkiHLpP9gzO+D8h5W7q3hThz6sTE3vJlHhiEtdizAwWL/tyxOy
         A8KEV/at0b1mOVWfQINf0bYrLjM27O4gxO4/EnHd/5HUDweCZj8zUsUe3z3YZ54NQAJ/
         S2pw==
X-Gm-Message-State: AO0yUKXzZ4u61XFlZtLAbDGl+DBugSfdFL8ZaJACWzW1ZvOUW68CwXJo
        kNRrPPgQhovoNChDhBqWlqvdsY5gQR5VLNUe8Eo=
X-Google-Smtp-Source: AK7set8Ev/rvxQ6AA5czrHGNTUJDSCGkMTd/NMEhOVjjVXy6GaRozZJXYmirN30HSugA+YOVCRiSmdxZs2v3o/rxqyY=
X-Received: by 2002:a17:90a:9a90:b0:23d:3ff1:87b8 with SMTP id
 e16-20020a17090a9a9000b0023d3ff187b8mr663850pjp.8.1678809141074; Tue, 14 Mar
 2023 08:52:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:522:b05a:b0:4cd:5cca:44fc with HTTP; Tue, 14 Mar 2023
 08:52:19 -0700 (PDT)
Reply-To: fiona.hill.2023@outlook.com
From:   Fiona Hill <angelaemmanuel672@gmail.com>
Date:   Tue, 14 Mar 2023 08:52:19 -0700
Message-ID: <CA+OK53kC3=bDn46CAxR8pGQoPRP4_5LTZuNy8h-974v=Fppuxg@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.0 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:62c listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4989]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [angelaemmanuel672[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [angelaemmanuel672[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [fiona.hill.2023[at]outlook.com]
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  2.9 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

-- 
Hello,did you receive my message?
