Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3DA2697FD5
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Feb 2023 16:50:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbjBOPuP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Feb 2023 10:50:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbjBOPuO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Feb 2023 10:50:14 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE5D834F66
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Feb 2023 07:50:13 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id m20-20020a05600c3b1400b003e1e754657aso1919543wms.2
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Feb 2023 07:50:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:to:from:subject:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=kCRA2NpLCz0WhUePmGtb/JGCqYsCH1FbYCTAn8xR4Wc=;
        b=TxEKG8suHwe0TZ8P+ckdqXfwjeM4CvhfezoHW0UBCdskhwbLIvEl7AMMaTRRmx1AcK
         wtw/Dv6uyULsY2mph1lk9vCZHkev9AamNg8eH+xlyoCH2MmLARQmgoDNwZS1Mlv6cl/s
         t7Od4Rp53A/yy2QTzAo0xK6iQw6FZ5lvWa6x+taTw15c/HmYsDl8fqG2K26ovRdlzA/E
         Quy/+CgFwTuN26IQseFxFvHAXvLo+p2EEdgNcxTKF9/VtgaHHzhpuW7+Lk2Kv8eRqrhv
         Ch+Cu47y8dJBElhMwNWEvK7V8dnvczuShruFAdbvxQoPE9cZFqd8zkoAluNwtmF0fj7f
         YPvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:to:from:subject:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kCRA2NpLCz0WhUePmGtb/JGCqYsCH1FbYCTAn8xR4Wc=;
        b=Vwv0sMPl0LZgEXe+rLmJTYUWEg4xAAFIPDHJ1MZSCsh6J7Xwa/KD8GND5L74mfTdtJ
         v8N+XRy0zoIhyjAG+HWCPtTz3QQ+gr44m5uAXuYQuPDil6o0hXxpWWUyo2h0VZMcSWL/
         52kwmucmtZP/d7//YExHkW9VNW/VJZT2Bo3u5Hf092Tu1No2kPMoWLgoVGw0mEakumgP
         wxexajtaDSBZ7cfW4+79/0RhoI8A8CgON5o4QRB1Y//xMjeGp0jMhhnWjkizBVLonAZX
         F5yVScbsYHtU3lGkGBI0P+6HTL0S2GRQELZB15BiIx6p0B/KQMd9MCZmuvP8ZEOjIHLP
         kKxg==
X-Gm-Message-State: AO0yUKVzL3EouGimnxIuYXtBOzDZHN0O5/AunKK1gL3Xi9+pvXcbuDbk
        NyaDAaKjOhnpfHdz2BXu280sU7IfJaw=
X-Google-Smtp-Source: AK7set//HmflOYgvMs1gp7xdvxKeLFTUE79Gm+dnwxHydbb1nyD3WFvotaFjvr3mvGiFTO1TNlY2Vw==
X-Received: by 2002:a05:600c:4aaf:b0:3e2:59d:432c with SMTP id b47-20020a05600c4aaf00b003e2059d432cmr1400241wmp.17.1676476211986;
        Wed, 15 Feb 2023 07:50:11 -0800 (PST)
Received: from [127.0.0.1] (178.115.51.107.wireless.dyn.drei.com. [178.115.51.107])
        by smtp.gmail.com with ESMTPSA id u15-20020a05600c19cf00b003dc53217e07sm2676179wmq.16.2023.02.15.07.50.10
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Feb 2023 07:50:11 -0800 (PST)
Message-ID: <3adc6fb633bde8533b77ce1cbb0eda97@swift.generated>
Date:   Wed, 15 Feb 2023 16:50:05 +0100
Subject: Domain it-archiv.de
From:   Rudolf Schaefer <rudischaeferzk4@gmail.com>
To:     "" <linux-btrfs@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Sehr geehrte Damen und Herren!


Ich besitze derzeit die Domain it-ar=
chiv.de ,w=C3=A4ren Sie eventuell an diesem Namen interessiert?

Ich fr=
eue mich auf Ihre R=C3=BCckmeldung

Es gr=C3=BC=C3=9Ft

Rudolf Scha=
efer

-----------------------------------------------------
