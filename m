Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21D144AE779
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Feb 2022 04:11:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244778AbiBIDDc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 8 Feb 2022 22:03:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359784AbiBICvh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 8 Feb 2022 21:51:37 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27BACC0613CC
        for <linux-btrfs@vger.kernel.org>; Tue,  8 Feb 2022 18:51:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1644375093;
        bh=A4Q0e1kSSus7s6mCCAf3SdPCGI26gnEdcXwaWlZ/MhQ=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=PJiHrdxiiBK/Dw1KJr9ai1+y4o+9r9aLSiCQjfk6I5IAJ9ONeQz5GuBOu4c8DT3wc
         yovTSFy/a1QUJRBoJU+1VI6IK09i270TU8MM9ExTU4zSH7s8QKdFhxY12BVFAcevHG
         559l8bjrAoFKu2ldt+xVhmNdmfLsGSztV6TMpEmE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MdvqW-1nrVrO2C1e-00b1Or; Wed, 09
 Feb 2022 03:51:33 +0100
Message-ID: <4eabdfc5-e6a1-8ed9-c73b-eed1dc32b807@gmx.com>
Date:   Wed, 9 Feb 2022 10:51:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: Still seeing high autodefrag IO with kernel 5.16.5
Content-Language: en-US
To:     Jean-Denis Girard <jd.girard@sysnux.pf>,
        linux-btrfs@vger.kernel.org
References: <KTVQ6R.R75CGDI04ULO2@gmail.com>
 <9409dc0c-e99d-cc61-757e-727bd54c6ffd@gmx.com>
 <88b6fe3e-8317-8070-cb27-0aee4dc72cfb@gmx.com>
 <SL2P216MB11112B447FB0400149D320C1AC2B9@SL2P216MB1111.KORP216.PROD.OUTLOOK.COM>
 <61ad0e42-b38a-6b5f-2944-8c78e1508f4a@gmx.com> <stp1bs$l94$1@ciao.gmane.io>
 <43e00a03-c853-56cf-9cf6-dfb4f1d4694c@gmx.com>
 <634769aa-9a97-33f4-caa6-c66ca0f877f4@sysnux.pf>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <634769aa-9a97-33f4-caa6-c66ca0f877f4@sysnux.pf>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:mB927ZsoN1SxZ1rXjb4e5SJQa16gsSHFyBl6okNV2EWvfeoqCB6
 K31aqanFEd1lwHC7xj8w7iodCtkRxCCWkEa1Ls/Up8VgGvJoMLcrkg5RezSf3uO8vWjYjsx
 j5TX35xmW2zYOw2CSEvuKc92TFW9YaA/cyTsPKncCviCfHZzs/Qgn0US17yEY+DZ7c1YGFa
 0+ifuQa1Tc4pSOtR5QdUQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:PqC23cgi2nQ=:qVGQGr03+U8SsoXV7npeqp
 KwdAbLaKs6xct+bb7PHoWQi0MK74etzpa8diKkCw8uh9fW+93dy6CkNHeAyeYlTRP3CPZYLe+
 OtFK3WopSVzVjN3X82U8h9GARfkJfwdsrgw6iTRmOkRYj3CXLgUHEj8xk6eFz/tFiPztUk+mc
 LNiglQoL1QJRZzElwTQm3uRre/gBHPpDq269SgX9/7LSIJdV9ESRmFPDMUc+cQI+NJ3MuI43x
 HO3dwGYt1U9tQO1dnACoUtRMFXpZdxVQ/IRlvQpmWYe+uJqaH3QGDfQ9ZWqjRjZFrYtmrKa4p
 sthz7F5YBf5et4R8Ag7qs0qJ6vro2ipWue7rvv2S93UnGEmKuvgUI10TiDy0YbSifniCkhM5O
 UADJbBH/wH1/2LWwDPrEQCWXBc/vLMHD4QGQghXOXVn2xdHa+/MTd4vlgciXAS7i+GHPDluCE
 GdiDg6aPNfcChiS4UNrMR7B9hjsVFjpOs8cqZUw26RCU+qYrbDFVklFFa5peSADfEUGNK7SPd
 toxl4e4n11XSUTjCPXJApgUr777KzlQs0PVZU+jibBkadvpiaeQnlvIF4fzbAE/l+PisoP0g6
 3ksC+S25TjW4l9buuRUDltWhvwNMxtZW0iQw/kV8/ZzxZMAC9hixIQCSAe9BI5G80UzDi5OOr
 7ZB2MQM2wTWye01+uc1dfJKcuZ0gEIBv6GY67xkvHcIR2zgNBTz/naXBAFTqQxRDzgLw5tjM/
 jYl7KeYwSFlQHAHovKjZq4apHt+dpJwaZ8jD7GTuG/+khhOFixJUllCjl4Fk9oI3mgBHv3UDh
 BEX8ciBRONtE9BOH4++uAbwbQg5W9GbRwQA7s9ZGIAzmDZx6NF3oxGTgaX35svkp3zNIftV/p
 l116gdN5PdzPNus73mAy3yuEr6NuJOZJs0vJGNF3k2T5NvbaYbl2OnpRu+lh5KmIbkiyibgA6
 APr7tBpYCO214MnKiHFShfAnDfXrMzmRML1GAQUtEeJC7V22ofjYsNWBAXqLhl6p7U63GTm2X
 x0N505X0XQu8esREpPia3piX45Onz0RgPQFetMKeAm9bGiOvohikp1nJrgwB1J5DZl2mKpIOP
 8ktC0udkFUkIMs=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/2/9 09:56, Jean-Denis Girard wrote:
> Hi Qu,
>
> Sorry for late reply, and I still have not applied the last diff you sen=
t.
>
> But I wanted to report that without rebooting (uptime is 3 days 7 hours)
> or doing anything special, my system now behaves much better.
> btrfs-cleaner sometimes appears in top, but not for long period, and CPU
> usage is low. iostat seems reasonnable too.

Well, at least it's some good news.

BTW I have updated that branch on github, feel free to try (better with
the extra diff).

Just in case you have hit such situation again.

Meanwhile I'll try to rework autodefrag behavior to be more accurate.

Right now, autodefrag will try to scan the whole file if there is any
small writ to it.
And there is some questionable check on whether autodefrag should rescan
the whole file.

I want to change it to only scan ranges adjacent to the small write, so
we can avoid possible problem related to the whole file scan behavior.

Thanks,
Qu

>
> Not sure what to conclude...
>
>
> Thanks,
