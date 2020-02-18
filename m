Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D556E162279
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Feb 2020 09:38:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726225AbgBRIip (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 18 Feb 2020 03:38:45 -0500
Received: from mail-qk1-f172.google.com ([209.85.222.172]:46802 "EHLO
        mail-qk1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726193AbgBRIip (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 18 Feb 2020 03:38:45 -0500
Received: by mail-qk1-f172.google.com with SMTP id u124so18232519qkh.13
        for <linux-btrfs@vger.kernel.org>; Tue, 18 Feb 2020 00:38:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=wcUck/h+81pO5Tt5Kd7YjKkXBqT5F1kr3ihL8C0BOwM=;
        b=f5Fr4dNx1JnGEAyQykA2U7k5YGln+HnG6Vs4Bw05zJaEhjfxCAGLRooaZ6WG9vqBXX
         xA8PJsZbtTlIFkHi1dZrtJi6Pw64uXvf+SxsCe1iXATC7XPtkWuRmf4sOA3Pg7JJOqYZ
         e0dtetWIum1DMSxKXoG/SdY/58ldwl7dV1DzIizz3QNjXCo5R6DlQ9WHRix1a/7DGAnw
         XpRcTw5TgLO9IsJzi3krBKi5xcASSOAQyei32LLuy/KcYuQ3Cg8zsdlAmf7KXudCISuY
         YBBx7nlQCQBwmDT2rNoo2lRmAdmlp3AwEdGBPpF/1PM9fzmX8lJhen4Hal4Dy8dbXd4h
         GrDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=wcUck/h+81pO5Tt5Kd7YjKkXBqT5F1kr3ihL8C0BOwM=;
        b=jl3U/6Db/ngb0geftKnh88df02UlirlQYzS0odh4HQR+TgPMEg4u8Kygg5UV8n3HW/
         OrdSrkqBuMLeQqz4jS6Onh0iA4M6bFHMEw3P+t/owAySEfjDOFd771eo3YJBTdOoH/HM
         ZWdHog5DZCDfjP7MsEz+RT59dJ42Y31lY5MUZO+cznR8JjrutyH3Nm4c4aibaoE368nR
         GBFWvHUs2a9+TrLi96G1P42M7SI67By49sob0PHni7GHIo+uyrDZiI3bh/ttOWcZ1+hQ
         SOAZozvp9BMvtJcBjmig/CFIBf0aLkaxmkl1HKladLSUG4h8ncNV1BMQPqL72+lWsOsH
         4lcA==
X-Gm-Message-State: APjAAAWCdhF26Wt9YnT0W2GhVOSLs0Uj81LS4n2YFJZAJaBdUc9XmTv/
        YYRXxcWkZGJm0QxOC7oPuugPjbnjnYqQAHAhP6HcKFU3
X-Google-Smtp-Source: APXvYqxoZHwxZEfWTpKKvfuz6oH4PZnXe/RWfR9dxtXmjVINFimM1xHSQtHgrYtiXP1w3jhB2orbIOrudHPGKj0XXC8=
X-Received: by 2002:a37:7245:: with SMTP id n66mr18832632qkc.202.1582015122582;
 Tue, 18 Feb 2020 00:38:42 -0800 (PST)
MIME-Version: 1.0
From:   Menion <menion@gmail.com>
Date:   Tue, 18 Feb 2020 09:38:31 +0100
Message-ID: <CAJVZm6d9UXfn_sH-VHBNnm5M1tyb7j1A7ahpLMcvDCXAzAfHWA@mail.gmail.com>
Subject: btrfs-progs: balance start with convert does not fork in background
To:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi all

Is it normal that a command like:

btrfs balance start -mconvert=raid1 /array/mount/point

Does not fork in background? I have tried this for converting metadata
from RAID5 to RAID1 but it did not go in background, even if in
another shell brtfs balance status /array/mount/point reported the
status correctly

Bye
