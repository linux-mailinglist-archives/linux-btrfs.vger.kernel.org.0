Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B8875F9EBB
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Oct 2022 14:30:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231794AbiJJMa0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 10 Oct 2022 08:30:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231513AbiJJMaZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 10 Oct 2022 08:30:25 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9861DBC2F
        for <linux-btrfs@vger.kernel.org>; Mon, 10 Oct 2022 05:30:22 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id r142so4138919iod.11
        for <linux-btrfs@vger.kernel.org>; Mon, 10 Oct 2022 05:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RvTjEYU5OebqAwptvpYpYpSVM4iGSwiD7S5moKeGXdo=;
        b=bqV0F3ZlWh2EiOfgG3Gl1vr4Ww3LPVinE4f23Oj5/VSFDZtNWu6XrcEKzhPRkEXO2t
         wZlhE5qd2ng3QDa4uFtTHAQhGNghDUPZHeFW0zxeVhxTzCKeRlkMCXyRQLQOEqUhIIfj
         UrlWXmT0anyxWja6cUV9EOHyJlHXYXIfPxLijxH3iKMGqr1Wb+04z9ME+pqnFxpMxFC3
         v+dNnowpkJnl+rIQOJSzHdIDI8QAC+TDxQS27h1IsSETMKyhSlFhXxCzUpzRwRWp9wDw
         p23/4XybHQf3JLDUX+zRHzUvCyPNO7VSO0Vh/Pz1wOPY+iRvT/1BeAgpr+l4ViZp4WU1
         LbCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RvTjEYU5OebqAwptvpYpYpSVM4iGSwiD7S5moKeGXdo=;
        b=2FBGaMP0xC3PKqQ02p3k3F6oFHItoHI7vqrpqZxNoeKicCQSkk6astfAI8BMKqLgfZ
         VmLM09mS8HPKv+kZ5Tp0Il4nn9pfZXG0RryaxrWBpvvQ22YO10Cvz3I855pQdsg1avWi
         tHijIa2GA1KB+DGyAekpex9gShCEN5S5Z90u6SyjQLD60j9tEy/Mpika8U2q8LpI4UaQ
         Jv3LuyyQFL7u7qoLDpnbmEV7U839eWDfNhl88aAvkZlA4IeEhbseEinvHFx+fsFz/bD9
         OaHUos/qzmC2fvkVnsSQQ2QfXBSTxUFUs8sjlZNYpNJQwzzr46rzBs5gfllJYRU+NYKK
         vbWw==
X-Gm-Message-State: ACrzQf1Z5X0mZuoUP1GygyUgwEqPCBfmA8HgH88CB7EUhiuD6m4NsTLA
        iGIlrbhMudLTiFLANmcOOBkZehDDW/WFNfZWK0M=
X-Google-Smtp-Source: AMsMyM4gtS1tWo5eoUCHhGReMJuyXgVp9z3Ef/HJa1UnpLPSldhgx9he3t45GmZL70MTFnmJoViJNMyPjGqR1anvP2s=
X-Received: by 2002:a05:6638:12d4:b0:363:ad96:56e2 with SMTP id
 v20-20020a05663812d400b00363ad9656e2mr4485657jas.104.1665405021993; Mon, 10
 Oct 2022 05:30:21 -0700 (PDT)
MIME-Version: 1.0
Sender: ayegbekomi8@gmail.com
Received: by 2002:a05:6e02:1b0a:0:0:0:0 with HTTP; Mon, 10 Oct 2022 05:30:21
 -0700 (PDT)
From:   Capt Katie <katiehiggins302@gmail.com>
Date:   Mon, 10 Oct 2022 12:30:21 +0000
X-Google-Sender-Auth: dqWwEit4apUcxuLNtO6eMvB-qSo
Message-ID: <CACWbVsqmD2M=MkirJ0P_fS4JZgxm_yj+KgxfgJb0bUgG1EeN2A@mail.gmail.com>
Subject: RE: HELLO DEAR
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=1.4 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,SUBJ_ALL_CAPS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Witam,

Otrzyma=C5=82e=C5=9B moj=C4=85 poprzedni=C4=85 wiadomo=C5=9B=C4=87? Kontakt=
owa=C5=82em si=C4=99 z tob=C4=85
wcze=C5=9Bniej, ale wiadomo=C5=9B=C4=87 nie dotar=C5=82a, wi=C4=99c postano=
wi=C5=82em napisa=C4=87
ponownie. Potwierd=C5=BA, czy to otrzymasz, abym m=C3=B3g=C5=82 kontynuowa=
=C4=87,

czekam na Twoj=C4=85 odpowied=C5=BA.

Pozdrowienia,
Kapitan Katie
