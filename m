Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F223154AD9
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Feb 2020 19:13:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727747AbgBFSNz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 6 Feb 2020 13:13:55 -0500
Received: from mail-io1-f53.google.com ([209.85.166.53]:37166 "EHLO
        mail-io1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727703AbgBFSNz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 6 Feb 2020 13:13:55 -0500
Received: by mail-io1-f53.google.com with SMTP id k24so7384972ioc.4
        for <linux-btrfs@vger.kernel.org>; Thu, 06 Feb 2020 10:13:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ulRWRcKUaiH1efhT4lSTRl3NA34p+HCm79zrqCkkvp4=;
        b=gmUx6q6lVMMEjP6Ku3lt8InVQWTk54i65pUz9fioiy2v8pgsDDLZjIULDhkeGZ2G4+
         UAOCNk5blc32Yj3cCbYBR7ctosT8+ud/z4tddVOBmsZeFTDQvBC9toeEUjQawOrjDl9P
         CUJlIz1/SbCFzAzrtYatF4lLYfSd5HLstwUCJasICh9coZVep6RD7StnDFlsY+eRHqW5
         YUKbXIpvUWCavM4mGUO0uUq7/y330o/K2gUCoNc/FDxd6ARC0U00pHCJXPrEerRQWdH4
         eyu1ZvgqWMhuB/ZiHcuKxT8FTQchXDW4AP2u6WtrClhTd/RsBphz0R56J3VCPHwHRlCn
         VNVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ulRWRcKUaiH1efhT4lSTRl3NA34p+HCm79zrqCkkvp4=;
        b=NHe7k14EzMf6NcCbnZzSo9+jqaplqiRy19NpOoeLsFcG9m+tNIVoCdMBHme9YvQ+W0
         lHfKEePqT0ec4D1ahW6jQC2yIl4yEG5u6YxZ+6UptmWizHODtzGvT+Qa3ONNIGZC6eQI
         P1YleMDlqjq500pkXJ0qVvxdp8IXlOOnCEm1e9jwloHfAuyrdBcBQBSKjw+xc8+iWDoV
         JtRBxGVMSc8RlqBgYSfA3fClyPFEDRciLFDn0bH3MMymx3voD3IwkrUMPt2pnnqZfUFS
         7MbOWr8abc4DfYWCgdPod4G5A4IiTTI6wLL9KhdkG+jakQkX0NDvA6ki953NZZVGhTzq
         0j1w==
X-Gm-Message-State: APjAAAU8u7suDeXe48J8/X+Zm2i9dXQWnuxj9k5dNDg6ulFkSrtJqTKH
        +9D77WlJbkafrN7mgxl/B2U/M+kUFgfHvr9lCVY=
X-Google-Smtp-Source: APXvYqwMEB8VLKp0Jmp5nPGnhNU1HrCel80nYoO1Ri8FvV7oi9dBqQ1jXdxCl5qbaTJztB1DlMisP3c4Ic0jzUSFbzY=
X-Received: by 2002:a05:6638:34e:: with SMTP id x14mr10909350jap.38.1581012834468;
 Thu, 06 Feb 2020 10:13:54 -0800 (PST)
MIME-Version: 1.0
References: <CADkZQan+F47nHo49RRhWLi2DfWeJLrhCYvw4=Zw_W7gFedneDw@mail.gmail.com>
 <CAOLfK3UoH1akySt47Wg8JDDFCHqbcm8otZyEAPp1jX0Ye+41-w@mail.gmail.com>
In-Reply-To: <CAOLfK3UoH1akySt47Wg8JDDFCHqbcm8otZyEAPp1jX0Ye+41-w@mail.gmail.com>
From:   =?UTF-8?Q?Sebastian_D=C3=B6ring?= <moralapostel@gmail.com>
Date:   Thu, 6 Feb 2020 19:13:41 +0100
Message-ID: <CADkZQanf+--iDj3Y+toiRybPZC2UsCtbuCn7BQb6d8FeqLSeXw@mail.gmail.com>
Subject: Re: btrfs-scrub: slow scrub speed (raid5)
To:     Matt Zagrabelny <mzagrabe@d.umn.edu>
Cc:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

(oops, forgot to reply all the first time)

> Is RAID5 stable? I was under the impression that it wasn't.
>
> -m

Not sure, but AFAIK most of the known issues have been addressed.

I did some informal testing with a bunch of usb devices, ripping them
out during writes, remounting the array with a device missing in
degraded mode, then replacing the device with a fresh one, etc. Always
worked fine. Good enough for me. The scary write hole seems hard to
hit, power outages are rare and if they happen I will just run a scrub
immediately.
