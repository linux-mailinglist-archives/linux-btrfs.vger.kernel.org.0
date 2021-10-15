Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F69042F644
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Oct 2021 16:52:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236907AbhJOOy6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 15 Oct 2021 10:54:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230471AbhJOOy5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 15 Oct 2021 10:54:57 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A45DC061570
        for <linux-btrfs@vger.kernel.org>; Fri, 15 Oct 2021 07:52:51 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id s136so5588239pgs.4
        for <linux-btrfs@vger.kernel.org>; Fri, 15 Oct 2021 07:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=KzpWrXZNvDmEz2eZbSasSqj1+9Uxu2H3QMUpmMIjAfs=;
        b=QaPqt+DqY8r3V1OqtVoc1hXtt4IfUDQSQzyaP23Tn/2aoqt3GislZGzXYyF9yk5zAw
         +QrrwPF5fqGVxRS6c5tmSDXgBcIoBmNbvE42ucg+rn3Y6gEwZi1Disr+8+9zAc/4QFh5
         Bvl03C6lFClz04QkTOZNOtBF6GKIoTAsAGRQBvPpm8ydMazfHwFr7Fo9Mharx98AmNly
         AFlAvsosDK4zF7tue5kU6TsmZlJVHkMIBODBAa191M7TfbTAMAMlFEUaAB2RSQ8AP4kh
         iFUycuvVUmjCF+DHlMYYKj+wMHnGOChvJ0aH5cg6j+HaMxs4vqKE8NOi6zoLskFsxdVA
         7QAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=KzpWrXZNvDmEz2eZbSasSqj1+9Uxu2H3QMUpmMIjAfs=;
        b=mG9T3QGOghYTeht5EW49p6XP1Gb63KGIGLPoaw8irIPauni52cgwUPmB+dyOjKfZQF
         vSf8hqDosJK1nMykdyDBWFk0URAUfv5X/AX7/k5OSMfGDpq9qjnuRdBoqqjgokjDjASK
         Qu0ZVTF10jwI/sIJ5BvGPlqY97ZKKVezFMXV045gYZmYPGSSjKNW3JflKOXGBzTPsVPp
         UbX/LQKA9WL3YfufBadq9pHmfr2UkNn2OIxjcg/X0l02MU5O8neJvI1lPOIw3CitDnu1
         ftrHUiQwTmkC6zyORI1MbXkFdiLuDQzfWiNUs8j2s3Qd4zgLBV1tRFSYwgIEegWSj9Ib
         NM2A==
X-Gm-Message-State: AOAM533TkYzQC7JvA7TT2UFSk3N4VoTQzNWYjl/2Uko1UkO/M4tQqlJ3
        MYoVj72InG9JG24g60awACSkXsUfQ+qqELFw34c=
X-Google-Smtp-Source: ABdhPJy9Y/mwQOaq1gO6Qk0ZISouAi4xn0JoZGfQ8Lfc8dt//rUmka9MJqDibSixhVJ9MWdkv6y+4nsHLSCRXYduc0c=
X-Received: by 2002:a63:6d0d:: with SMTP id i13mr9480961pgc.25.1634309570773;
 Fri, 15 Oct 2021 07:52:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6a10:fe09:0:0:0:0 with HTTP; Fri, 15 Oct 2021 07:52:50
 -0700 (PDT)
Reply-To: donaldcurtis3000@gmail.com
From:   Donald Curtis <bigladjamal2@gmail.com>
Date:   Fri, 15 Oct 2021 15:52:50 +0100
Message-ID: <CAMxyq03v_1CFPSWsX4_e1JWWVrnFSpiSFDa7-WjJB+q+uDigaw@mail.gmail.com>
Subject: hi
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

SEksDQpHb29kIGRheS4NCktpbmRseSBjb25maXJtIHRvIG1lIGlmIHRoaXMgaXMgeW91ciBjb3Jy
ZWN0IGVtYWlsIEFkZHJlc3MgYW5kIGdldA0KYmFjayB0byBtZSBmb3Igb3VyIGludGVyZXN0Lg0K
U2luY2VyZWx5LA0KRG9uYWxkDQoNCg0K7JWI64WV7ZWY7IS47JqULA0K7JWI64WV7ZWY7IS47JqU
Lg0K7J206rKD7J20IOq3gO2VmOydmCDsnbTrqZTsnbwg7KO87IaM6rCAIOygle2Zle2VnOyngCDt
mZXsnbjtlZjqs6Ag7Jqw66as7J2YIOq0gOyLrOydhCDsnITtlbQg7KCA7JeQ6rKMIO2ajOyLoO2V
tCDso7zsi63si5zsmKQuDQrqsJDsgqztlanri4jri6QsDQrrj4TrhJDrk5wNCg==
