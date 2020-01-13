Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2DB1F139A45
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Jan 2020 20:41:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728665AbgAMTlQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 13 Jan 2020 14:41:16 -0500
Received: from mail-wr1-f54.google.com ([209.85.221.54]:33460 "EHLO
        mail-wr1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728641AbgAMTlQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 13 Jan 2020 14:41:16 -0500
Received: by mail-wr1-f54.google.com with SMTP id b6so9895469wrq.0
        for <linux-btrfs@vger.kernel.org>; Mon, 13 Jan 2020 11:41:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=ewa3yXWKa9w+L45ZZgqJUOWyS3NVSFzO8w4ok/jL/T0=;
        b=NA57WtfVTxTeC0Tgg2q+TRidpRP2gLLxtBahJXL74AhNyk2YwwQGc1Chc1HmrPHRxZ
         MUju9Wnrxp4U5W32gOr66nveNogSg4e9laijwTPTjVdy1ytXZPX6SC9BGgwczhdTb5fe
         XV1pKcsFNVFYogq9OlWxJZDmypsm+vk1RswxI2T4MKm8jFfAQ7GnMmiZHLisTcl4VTho
         sS9C8hZhKvvtYxpNDU++UrrPXrN4HHdMomYEFva9qKclkRSakqzLLew21aHmm663P2js
         u7UqBAfu3J/rrLPuvtA9Qr5lXf4C2K8E8Oe/cIQyVkFUJFI1H8cPInmvhQrZNU8u5jzd
         ZzLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=ewa3yXWKa9w+L45ZZgqJUOWyS3NVSFzO8w4ok/jL/T0=;
        b=KVVanILFggKIe+NB+jsGRVZ7Fe4gubd6Hgi10pndCBdoAatu8ReVrf1lRXQkRm0kXw
         ouHArUJC74wzVKZLPFGhaKEfAgWuT2YzrnHpm+Hu1zHo+ZWn7mC0eACVwnPvHu1SKlKH
         2lwPNs1HQNvXJWB3h70bY19lGmnrdmCraNASzktTGXIVioceoRuOj8ySGRmwhJ37YLLR
         ufbSwWTExTOxbOm3zEQ90gkmxLEWj+FG/bqiUpFrUGFOPS0RLTtXf2RS243A16bRxVCt
         lyUEpWrRkM7GETr5f83PXIgG67u+EF0jcSUK5EULbGDU58Ki0IGejpVE8o8DA7mVHMqk
         iITQ==
X-Gm-Message-State: APjAAAV0SkIcd75+d4WzaOTSdLZq3/IUEqqBXlwryZCBR6Fiflav1q2k
        1imQZp2RXq1LYhvQx+dhNjoUd2fI07xxen15ck2LRL2/bZ/OMA==
X-Google-Smtp-Source: APXvYqyrG+ZpiBZQK8NuVarnUVUL0mPIcBPHPqvjkULjO4oZC6i+/EdkSsPafk4Er8Bh9CV8PK+ejb7xohiv3QBJLcw=
X-Received: by 2002:adf:f6c8:: with SMTP id y8mr20329280wrp.167.1578944473368;
 Mon, 13 Jan 2020 11:41:13 -0800 (PST)
MIME-Version: 1.0
From:   Chris Murphy <lists@colorremedies.com>
Date:   Mon, 13 Jan 2020 12:40:57 -0700
Message-ID: <CAJCQCtR4a-StkTKZdf4REbi=N7wWKODKp-9nJwhwknrdgwNVWw@mail.gmail.com>
Subject: are reflink copies atomic on Btrfs?
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I was referred to this on the XFS list
https://www.spinics.net/lists/linux-xfs/msg15969.html

That suggests that, at least in theory, they are atomic on XFS. But
I'm not sure what that numbered list looks like on Btrfs either, and
whether there are expected differences.

Thanks,

-- 
Chris Murphy
