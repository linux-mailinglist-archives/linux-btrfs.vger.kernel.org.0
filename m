Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF51E26A0C
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 May 2019 20:47:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728958AbfEVSqz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 22 May 2019 14:46:55 -0400
Received: from mail-ua1-f54.google.com ([209.85.222.54]:46248 "EHLO
        mail-ua1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728450AbfEVSqy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 22 May 2019 14:46:54 -0400
Received: by mail-ua1-f54.google.com with SMTP id a95so1231647uaa.13
        for <linux-btrfs@vger.kernel.org>; Wed, 22 May 2019 11:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ceremcem-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=uSx+43K9wxYbPvivXHUn0Z1XUltFhsiLtpgUhZNxfuo=;
        b=VqZB6sUrcmZgmjChDqiLl68XCHI9JnQxAyeyebWO7PwT1plYO6e6+lHVqvzZkc8HBm
         WIKidmB+fP2IUVrzp+ex5ubigw+27tRycXz/gPqw7Y4OuTr2fjSe4giWN78YOyj6+wJJ
         f9zT6wiSxLoT+Gt+lArWGzMZ5NNquspk55WPxeKW477jA0O7UZAnX2xe0inCLPQ2xS+j
         Pcm1XL8ajhfcgjIVM/2vFOXTbf5SENM/m/5Kgwibj8pm4WNV/3JYA5Xqzk9l5AefzK14
         BOrew9MIMDGl1ljkYPoUR3eKtm0EgkVEoDVC0cMPynGCSQkNGXc1m3/qCi44G1GpJt6m
         QAyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=uSx+43K9wxYbPvivXHUn0Z1XUltFhsiLtpgUhZNxfuo=;
        b=ajWzYWw+RorsJCeeB1ACpQ89HbpRB223D2zatoLlzvPpEEAwbh6CFfRZp27E/SSZL4
         Z5CnWYQa4Dqb0y9vV8ZSMqg7gMaiEe5X2CCYfiPELV2keZnCKoQlRty6K+n8dBlLGHDP
         5Zr/+XTn/E4XdP2/cd8cScSgKzJbkeZeBOixmJQCIUtwupFzFaM27a4PfiaKcQuEJrd1
         ICHAhgdp0KG/aR7u31GIEjbMVvz0hl7RtMJkkIXf6vf2MDWywPhDdIgCUeoZ3qJ3HZvm
         ZxIUu0gdI9cF17jkgfH0agSjHbQ2noDf4a/T1jBEKsLR63XqIjBPu0flvKVeHKb6Qy6C
         lAgg==
X-Gm-Message-State: APjAAAXQ5Ol9kyVQmH5wCYE7Mgt2byt8XYsSV0qSx+xyEBFrI1aSJ7TX
        4v0azLF3NM/JhEpblvajbZK22pOOD+O3i95n3DBjGn3yfwuQ22Ci
X-Google-Smtp-Source: APXvYqwIRJ9KYoVJ8+cfaXmQKXu1tF1IhF98Mcdkgy4ALPsHRiDh/Dg6GLwCPDFAYtNfjdsT/UFL88oBQGqliz2gwbs=
X-Received: by 2002:ab0:671a:: with SMTP id q26mr41468215uam.7.1558550813732;
 Wed, 22 May 2019 11:46:53 -0700 (PDT)
MIME-Version: 1.0
From:   Cerem Cem ASLAN <ceremcem@ceremcem.net>
Date:   Wed, 22 May 2019 21:46:42 +0300
Message-ID: <CAN4oSBeEU+rmCS8+WwriGz0KoPR=Xa6KvjH=gGriFaxVNZHf6Q@mail.gmail.com>
Subject: Citation Needed: BTRFS Failure Resistance
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Could you confirm or disclaim the following explanation:
https://unix.stackexchange.com/a/520063/65781
