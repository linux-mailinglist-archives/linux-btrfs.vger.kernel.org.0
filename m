Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF9A41C0365
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Apr 2020 19:01:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726433AbgD3RBV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 30 Apr 2020 13:01:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726333AbgD3RBV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 30 Apr 2020 13:01:21 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEDC8C035494
        for <linux-btrfs@vger.kernel.org>; Thu, 30 Apr 2020 10:01:20 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id e26so115760otr.2
        for <linux-btrfs@vger.kernel.org>; Thu, 30 Apr 2020 10:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=CQPj5qM+tdudsr2kqqrtSJscfnFWKBZVeMmZgNW+UHk=;
        b=L0JfmW40UGypW9y0GsJcov/J4cMhEGRCTACW5bLKYGdYLjxE7elNN2FuugBBfQ72Xg
         QqaSGEnu9krQtHFWT7LLtlJGsfKLuLBDjpTRth4oLvYnKMRti+xJ+oUtXWTA0JHIpeF2
         /1KiVU1yUGfC764ymp3AXMEVVG5t7/BJjqaR564YUiuw/Ej1MrkbF7a9B5tvcKN3AQFb
         ibdAYw9LnCUOj+VNqXzQyVea9kVardA20gZtyGOiwzvXYTIw9v60OzUFOvoXn3sUb6Dy
         leU31waaYhalYY70tM0BJDGpHFqK/Nd4M/wEaJKSkDd+URVMd1UAc7UCkI5nDpZTl7BN
         D/qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=CQPj5qM+tdudsr2kqqrtSJscfnFWKBZVeMmZgNW+UHk=;
        b=ISxJuRWu0733VCe36MbYgoTiVxgHJs0XXYlk7ajrs4DU/3XQiwl1i3MqQqw03aICdV
         Y2jQYm8T2cKZNgTuAT4kZ6l7mH20RHiW+jElULa51P86bdO3Hs4G6FJurVg/WpuaRR7B
         8gqJiypSivQJijBRy2qfuWA5Kj4n7TRnYocXCm+h4nw6duEzoo6EyeUWE+ZxqHxianvK
         f59uBSCqVmuD9qKYRJkhrpD5PfcvR7X05g2GJy4cm1i7bN04hGAOf+r91t+fB5MLL9XW
         sqq1ktyjDvid+12jIgf+w8hHZ+tUxYzeLdADJicwmusJP5eA7Oybe2Lr6ksbPvbh0mYb
         dc8g==
X-Gm-Message-State: AGi0PuZUZtkT3UQsNAbp54KwImyLjU9S2HmYr7c5q+v8tCiaceu37BkE
        1T4rpDRBIg3Xrq/rEtYayA/GAbGVaQ1NCIkdIr25oD/i628=
X-Google-Smtp-Source: APiQypLbhsXxqU7CSYLEwSD0BNrKXw4fzNIndbvon1MSgAp/1jjDR+OzOZ5LF7mYl/6MnPH2obYIu4XzXprYM639EUU=
X-Received: by 2002:a9d:7390:: with SMTP id j16mr27135otk.43.1588266078598;
 Thu, 30 Apr 2020 10:01:18 -0700 (PDT)
MIME-Version: 1.0
From:   Rollo ro <rollodroid@gmail.com>
Date:   Thu, 30 Apr 2020 19:00:43 +0200
Message-ID: <CAAhjAp1zrjrizrswo3BF1-cTXArpZ5XFUPbd-OR_Nu1N05pdSQ@mail.gmail.com>
Subject: raid56 write hole
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi, I read about the write hole and want to share my thoughts. I'm not
sure if I got it in full depth but as far as I understand, the issue
is about superblocks on disks, the superblocks containing addresses of
tree roots and if the trees are changed using copy on write, we have a
new root and it's address needs to be written into the superblock.
That leads to inconsistent data if one address is updated but another
one is not. Is this about right? (I'm not sure whether we are talking
here about a discrepancy between two root adresses in one superblock,
or between two superblocks on different disks or possibly both)

In my opinion, it's mandatory to have a consistent filesystem at _any_
point in time, so it can't be relied on flush to write all new
addresses!

I propose that the superblock should not contain the one single root
address for each tree that is hopefully correct, but it should contain
an array of addresses of tree root _candidates_. Also, the addresses
in the superblocks are written on filesystem creation, but not in
usual operation anymore. In usual operation, when we want to switch to
a new tree version, only _one_ of the root candidates is written with
new content, so there will be the latest root but also some older
roots. Now the point is, if there is a power outage or crash during
flush, we have all information needed to roll back to the last
consistent version.

We just need to find out which root candidate to use. (This is why I
call them candidates) To achieve that, the root candidates have an
additional attribute that's something like a version counter and we
also have a version counter variable in RAM. On a transition we
overwrite the oldest root candidate for each tree with all needed
information, it's counter with our current counter variable, and a
checksum. The counter variable is incremented after that. At some
point it will overflow, hence we need to consider that when we search
the latest one. Let's say we use 8 candidates, then the superblock
will contain something like:

LogicalAdress_t AddressRootCandidatesMetaData[8]
LogicalAdress_t AddressRootCandidatesData[8]

(just as an example)

While mounting, we read all '8 x number of trees x disks' root
candidates, lookup their version counters and check their checksums.
We have a struct like

typedef struct
{
    uint8_t Version;
    CheckResult_te CeckResult; /* enum INVALID = 0, VALID = 1 */
} VersionWithCheckResult_t

and build an array with that:

enum {ARRAY_SIZE = 8};
VersionWithCheckResult_t VersionWithCheckResult[ARRAY_SIZE];

and write it in a loop. For example we get:

{3, VALID}, {4, VALID}, {253, VALID}, {254, VALID}, {255, VALID}, {0,
VALID}, {1, VALID}, {2, VALID}
(-> Second entry is the most recent valid one)

We'd like to get this from all disks for all trees, but there was a
crash so some disks may have not written the new root candidate at
all:

{3, VALID}, {252, VALID}, {253, VALID}, {254, VALID}, {255, VALID},
{0, VALID}, {1, VALID}, {2, VALID}
(-> First entry is the most recent valid one, as the second entry has
not been updated)

or even left a corrupted one, which we will recognize by the checksum:
(-> First entry is the most recent valid one, as the second entry has
been corrupted)

{3, VALID}, {123, INVALID}, {253, VALID}, {254, VALID}, {255, VALID},
{0, VALID}, {1, VALID}, {2, VALID}

Then we walk through that array, first searching the first valid
entry, and then look if there are more recent, valid entries, like:

uint8_t IndexOfMostRecentValidEntry = 0xFF;
uint8_t i = 0;
while ((i < ARRAY_SIZE) && (IndexOfMostRecentValidEntry == 0xFF))
{
    if (VersionWithCheckResult[i].CheckResult == VALID)
    {
        IndexOfMostRecentValidEntry = i;
    }
}

for (i = 0, i < ARRAY_SIZE, i++)
{
    uint8_t IndexNext = CalcIndexNext(IndexOfMostRecentValidEntry); /*
Function calculates next index with respect to wrap around */
    uint8_t MoreRecentExpectedVersion =
VersionWithCheckResult[IndexOfMostRecentValidEntry].Version + 1u; /*
Overflows from 0xFF to 0 just like on-disk version numbers */
    if ((VersionWithCheckResult[IndexNext].Version ==
MoreRecentExpectedVersion) &&
(VersionWithCheckResult[IndexNext].CheckResult == VALID))
    {
        IndexOfMostRecentValidEntry = IndexNext;
    }
}

Then we build another array that will be aligned to the entry we found:

VersionWithCheckResultSorted[ARRAY_SIZE] = {0}; /* All elements inited
as 0 (INVALID) */
uint8_t Index = IndexOfMostRecentValidEntry;
for (i = 0, i < ARRAY_SIZE, i++)
{
    VersionWithCheckResultSorted[i] = VersionWithCheckResult[Index];
    Index = CalcIndexPrevious(Index); /* Function calculates previous
index with respect to wrap around */;
}

With the 3 example datasets from above, we get:

{4, VALID}, {3, VALID}, {2, VALID}, {1, VALID}, {0, VALID}, {255,
VALID}, {254, VALID}, {253, VALID}
{3, VALID}, {2, VALID}, {1, VALID}, {0, VALID}, {255, VALID}, {254,
VALID}, {253, VALID}, {252, VALID},
{3, VALID}, {2, VALID}, {1, VALID}, {0, VALID}, {255, VALID}, {254,
VALID}, {253, VALID}, {123, INVALID},

Now the versions are prioritized from left to right. It's easy to
figure out that the latest version we can use is 3. We just fall back
to the latest version for that we found a valid root candidate for
every tree. In this example, it's index = 0 in the superblock array.
So we use that to mount and set the counter variable to 1 for the next
writes.

As a consequence, there is no write hole, because we always fall back
to the latest state that is consistently available and discard the
last write if it has not been finished correctly for all trees.

notes:
- It's required that also the parity data is organized as COW trees. I
don't know if it's done that way now.
- For now I assumed that a root candidate is properly written or not.
One could think of skipping one position and go to the next canditate
in case of a recognized write error, but this is not covered in this
example. Hence, if there is an invalid entry, the lookup loop does not
look for further valid entries.
- All data that all 8 root canditates point to need to be kept because
we don't know which one will be used on the next mount. The data can
be discarded after a root candidate has been overwritten.
- ARRAY_SIZE basically could be 2. I just thought we could have some more

What do you think?
