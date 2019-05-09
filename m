Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C19FB18EA1
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 May 2019 19:04:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726653AbfEIRET (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 9 May 2019 13:04:19 -0400
Received: from mail1.protonmail.ch ([185.70.40.18]:63128 "EHLO
        mail1.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726617AbfEIRET (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 9 May 2019 13:04:19 -0400
Date:   Thu, 09 May 2019 17:04:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fomin.one;
        s=protonmail; t=1557421456;
        bh=HZ1X62dC6Gj8UwT3RhRdY663WS+DftRaLkLUraSiD74=;
        h=Date:To:From:Reply-To:Subject:In-Reply-To:References:Feedback-ID:
         From;
        b=Z6khcaey8ZZZqdgc62V+OUcmI6/cEibv06jC6OLe0ZyQoIxuHYlnqGrxl3qZ8CzIH
         XOO+TjF95+PdMhis8UP35oUDu+YB9i0hO/j1ySKrQUm+SK87jpKUIuee8Uo8C7WWed
         C/ScKjDy13xji0DZ28uha95UKrr6Bf/vDPXiwmRM=
To:     Andrei Borzenkov <arvidjaar@gmail.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
From:   Maksim Fomin <maxim@fomin.one>
Reply-To: Maksim Fomin <maxim@fomin.one>
Subject: Hibernation into swap file
Message-ID: <hHUq9SQfm-rxaa4ZlD815Pm8OwYY7CyglT0TcRVbm42v1fZrsadaNN_sDoxqXrmf55CcYmbWXKuYMEd1Unve5HVTXK-qchse-p9rfs0JYG4=@fomin.one>
In-Reply-To: <60258f5c-e78e-da10-fa19-29038803e160@gmail.com>
References: <aeo6MlQ5-4Bg33XbJZWCvdhKuo0Cgca_eNE4xv7rqzCzgvyxG-cobpf8R3bGdh6VT2LLPcXlZu69EyL_rV8K7gRLQ4HtYIyXnWCWb3zR6UM=@fomin.one>
 <596643ce-64f8-121f-3319-676e58d700e7@gmail.com>
 <CAJCQCtTsSRAHR-zwPq6GgmiCjDjE2MV-QekNUdQ2mWMAzVU89A@mail.gmail.com>
 <BbXmRr84cUaKIXCRo64oHylITD5VfRS5r1IeI3r2kNC-6gMrgJTyTU8MriZHfFwCilQBXXUNfQ3G3dcFxLs6FyP1KnjkcCsmVh3xZmAdR9Q=@fomin.one>
 <60258f5c-e78e-da10-fa19-29038803e160@gmail.com>
Feedback-ID: KdoJEVg5m21Zx-ZSt0YICttvNlCPIx4ISbXx_ujMcsAL9BeL-sYmJMAlEoWM-R55KO6tZ96oLFF00uPgMM7IOA==:Ext:ProtonMail
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=7.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF autolearn=ham
        autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on mail.protonmail.ch
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90 Original Me=
ssage =E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90
On Thursday, May 9, 2019 6:13 AM, Andrei Borzenkov <arvidjaar@gmail.com> wr=
ote:
> I think we need to allow at least some amount of trust to developers and
> expect that this feature would not be released if it had such an obvious
> problem.
>
> Of course bug happens and it surely needs wider testing.
>
> > Best regards,
> > Maksim Fomin

Nowhere in this thread I critiqued developers for releasing btrfs with obvi=
ous problems.

What was released is 'swap file support' (from changelog). This does not ne=
cessarily mean 'swap file hibernation support'. That's why I asked question=
 about this. After receiving answers here and reading linux/systemd bugzill=
a, I decided that I am not interested in hibernation in swap file because i=
ts costs outweigh my potential benefits. This has nothing to do with trust.

Best regards,
Maksim Fomin
