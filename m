Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC67419886F
	for <lists+linux-btrfs@lfdr.de>; Tue, 31 Mar 2020 01:42:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729021AbgC3Xme (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 30 Mar 2020 19:42:34 -0400
Received: from mail-wr1-f46.google.com ([209.85.221.46]:46700 "EHLO
        mail-wr1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728980AbgC3Xme (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 30 Mar 2020 19:42:34 -0400
Received: by mail-wr1-f46.google.com with SMTP id j17so23678499wru.13
        for <linux-btrfs@vger.kernel.org>; Mon, 30 Mar 2020 16:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bg8X9SsoHCL2o+280KBP6YZbX3GkuitMC9YyN53K2F8=;
        b=LiZNf9SDvxEoHbKao5sarRphv9PTZmGocHRCTuf7Kez6Y6olvQOvZ0mV/Qb6B8rNPJ
         lvoH+kZxLpihMT5jPGLg1KxrG76mStB7kukAW7pcrGfIwj1plKkj7KxC3OFAzzz4qaA1
         Ktitg+CXEvaStTZW0QddlSPMKP2nECLbviWTsN8YTxEyMJjwP26xYX48JV3NEj9mOEHd
         5J8LmrzZ/fDCkEGl62isSTMoqqWnIiQdqN38GP2lf4HPpkfw+mNYG+R7S1Mr+BnV2LhT
         gHQEBRqcf7EWTUsQ2fEft/YDxBiOYBYPzykNbZ7UNjC3S7wiHEBFbV61NufMVF+gWNjP
         wF1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bg8X9SsoHCL2o+280KBP6YZbX3GkuitMC9YyN53K2F8=;
        b=qpy54SOgVFJKlMearVtjwAJGxvl8kyKXai+/rTkozHJjTS6qgydmPVb46xMvhMbgkG
         sReDi9MTZc8+SJ0KXzS6VmBY5x7P6ik8H0dsZrTruik0FZsk3Ql/ZD1RWEceuelk4uRY
         9bOC/+ImTUvAa+4G2PlExC4A7M+70lXSChRFBKrQdwA0eqDSfCWYAaqBO3cBGA17mppP
         WnMzY9m4zpB+MxhTaMQFrWYpyuNIQoF7Z7utcF2Vq1R4oC8Y84EoNutyPGmfuNesYZha
         0CWZtXHI+VU3Pmb9HoppONbxuO2arRU+VYoa0uiXbx/1+wy2z+7FZ7WH63yn5SRMT3Mh
         trdw==
X-Gm-Message-State: ANhLgQ0pUAEbep7GEq3hWJcl4aEln9RpsTzcInS8NJWTTyBQ+R1cpVMF
        ZzlHdtY+bdTcj6ToUCXoPDJJ8l4udVWJCEC9GWBJSj8GR/E=
X-Google-Smtp-Source: ADFU+vuIsfqPRJdoIaG4vjoyYiEOqGMvSyWFj5uMdYtblc9gnp6L9296olgmRqxqeSoaU4d2Iei6eqj9UwkBttAOoFM=
X-Received: by 2002:a05:6000:4:: with SMTP id h4mr16938768wrx.236.1585611751157;
 Mon, 30 Mar 2020 16:42:31 -0700 (PDT)
MIME-Version: 1.0
References: <CAOH-_yXQD9D1emP6bPw1vO3SYfxxVqy8D5ONRXnZTbBeEgyPrw@mail.gmail.com>
In-Reply-To: <CAOH-_yXQD9D1emP6bPw1vO3SYfxxVqy8D5ONRXnZTbBeEgyPrw@mail.gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Mon, 30 Mar 2020 17:42:15 -0600
Message-ID: <CAJCQCtSzJdO5LpwUww=eBX1v_A9UcoqujR_BefH1t4MXmsedtA@mail.gmail.com>
Subject: Re: Corrupted btrfs after cpu overheat
To:     carlos ortega <carlosortega0113z@gmail.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

And also

# btrfs insp dump-t -b 37978112 /dev/


--
Chris Murphy
