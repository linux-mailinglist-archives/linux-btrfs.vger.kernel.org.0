Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8ED74342D9F
	for <lists+linux-btrfs@lfdr.de>; Sat, 20 Mar 2021 16:23:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbhCTPWy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 20 Mar 2021 11:22:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbhCTPWV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 20 Mar 2021 11:22:21 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8BD5C061574
        for <linux-btrfs@vger.kernel.org>; Sat, 20 Mar 2021 08:22:21 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id 94so9209678qtc.0
        for <linux-btrfs@vger.kernel.org>; Sat, 20 Mar 2021 08:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=PDZUudERkc0edi5fP/GUTNJvF7sCLvFD7qQ3pN46poM=;
        b=Vi2ewDyZNTyOlkhaq+4+BW3sSePJe1zpD9ZZOpWBkZikpw2UJvMcoQK02/gaUVVFFE
         8jjHgG1imTZ5XSpcswJ2Q7kqiM06e/+mk2D6d297gyQNlLK4OMpYB78Jfx/clBsIaStC
         77/KePIBN1sFKsZCCnQ1O5HAdJPfjgIkmR23Qy0dwqURHWEIuOynGQGKlGtaa88cg/xk
         167LpOZPYeX37Aei75YK8uT0Cxa5qTuWQfMlU6JTYyprfaTEQE9H0Z67B13rHeRPzrJf
         LB1ugoYXAiXK9WfhsLBC0ma/LIItxKERRzyS0Q6ziU2mPmI48tDFQ3FqMVJOUHafQLg6
         tj2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=PDZUudERkc0edi5fP/GUTNJvF7sCLvFD7qQ3pN46poM=;
        b=a23N1Vf6ivP9OYtL8V+Zl0Nvjx+JgF0wRprNf15af9QiL/K+3Me7FCb48B4VOCa5mb
         JdH0irvthwMIPFVsGpnICTN+nRhYupWvRdJyf16/nFcldOl76Ke+Ng2qKLpauk61AoUr
         5af+i1C+CDTaEiG2EBQsNCp6RT0lR0n29wIU+QQKJfBQ3nPyOWwiMlxdvXIrdK4PZP9J
         LSX3v042R/Y1CtPSBbIR0s6P25SJjcO0xt9ZZBtQBrFSy/jehWk3qjgpf2dXKmmd2Bf8
         3htdEuLIUnhT69zjXUPEM7a7VGcZvGb0EUT3jcz5iO2zrNs5pmBZrR1jpuzeO2MICdiI
         H7og==
X-Gm-Message-State: AOAM531qrSvxVnERsCb1ogzmlZhIwjDbJlJw+Rk81pDbFFLQ63/hel2G
        UYrsUMXBEcXGuRmP2i6wWk15h5phDU4=
X-Google-Smtp-Source: ABdhPJwhsLLovKS7qIfphsSHfPHfEwQFuEigMxEz0VsqBAi7VnMPG2UMLBtFpZfoulmycXb9FsuWtg==
X-Received: by 2002:ac8:6f02:: with SMTP id g2mr3276573qtv.385.1616253740693;
        Sat, 20 Mar 2021 08:22:20 -0700 (PDT)
Received: from MacbookPro.local (c-73-249-174-88.hsd1.nh.comcast.net. [73.249.174.88])
        by smtp.gmail.com with ESMTPSA id j12sm6027883qtn.36.2021.03.20.08.22.20
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 20 Mar 2021 08:22:20 -0700 (PDT)
To:     linux-btrfs@vger.kernel.org
From:   Forrest Aldrich <forrie@gmail.com>
Subject: APFS and BTRFS
Message-ID: <7ead4392-f4c2-2a5b-c104-ae8be585d49e@gmail.com>
Date:   Sat, 20 Mar 2021 11:22:18 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I have a really large (3+ TB) volume I am copying to a BTRFS volume 
(both over USB) which is painfully slow.  In fact, it will probably take 
days to complete.   My goal is to use BTRFS on that larger USB volume 
(it's an 18TB drive)....

I don't suppose there is a way to convert APFS to BTRFS :)   I know, but 
I thought I would ask as it seems like others may have a similar query.


Thx...


